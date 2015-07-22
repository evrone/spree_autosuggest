Spree::BaseController.class_eval do
  after_filter :save_search


  def save_search
    keywords = @searcher.try!(:keywords)

    if @products.present? and keywords.present?
      query = Spree::Suggestion.find_or_initialize_by_keywords(keywords)

      query.items_found = @products.size
      query.increment(:count)
      query.save
    end
  end
end
