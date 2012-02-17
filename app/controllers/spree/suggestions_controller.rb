class Spree::SuggestionsController < Spree::BaseController

  def index
    suggestions = Spree::Suggestion.relevant(params['term'])

    if request.xhr?
      render :json => suggestions.map(&:keywords)
    else
      render :template => 'errors/404', :status => "404 Not Found"
    end
  end

end
