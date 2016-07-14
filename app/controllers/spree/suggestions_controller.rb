class Spree::SuggestionsController < Spree::BaseController
  def index
    suggestions = Spree::Suggestion.relevant(params['term'])

    render json: suggestions.map(&:keywords)
  end
end
