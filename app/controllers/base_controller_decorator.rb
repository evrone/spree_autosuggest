Spree::BaseController.class_eval do
  after_filter :save_search


  def save_search
    suggest_on = Spree::Suggestion::Config.field

    if @products.present? and params[suggest_on]
      query = Spree::Suggestion.find_or_initialize_by_keywords(params[suggest_on])

      query.items_found = @products.size
      query.increment(:count)
      query.save
    end
  end
end
