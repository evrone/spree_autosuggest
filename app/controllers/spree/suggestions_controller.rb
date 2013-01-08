class Spree::SuggestionsController < Spree::BaseController
  # http://stackoverflow.com/questions/1988658/rails-action-caching-with-querystring-parameters
  caches_action :index, :cache_path => Proc.new {|c| c.request.url }

  def index
    if Spree::Autosuggest::Config[:search_backend]
      suggestions = Spree::Config.searcher_class.new(keywords: params['term']).retrieve_products.map(&:name)
      suggestions = Spree::Product.search(:name_cont => params['term']).result(:distinct => true).map(&:name) if suggestions.blank?
    else
      suggestions = Spree::Suggestion.relevant(params['term']).map(&:keywords)
    end

    if request.xhr?
      render :json => suggestions
    else
      render_404
    end
  end
end
