class Spree::SuggestionsController < Spree::BaseController

  def index
    suggestions = Spree::Suggestion.relevant(params['term'])

    if request.xhr?
      render :json => suggestions.map(&:keywords)
    else
      render_404
    end
  end

end
