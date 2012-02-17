Spree::BaseController.class_eval do
  after_filter :save_search


  def save_search
    if @products and params[:keywords]
      query = Spree::Suggestion.find_or_initialize_by_keywords(params[:keywords])

      query.items_found = @products.count
      query.increment(:count)
      query.save
    end
  end
end
