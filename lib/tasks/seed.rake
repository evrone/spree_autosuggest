namespace :spree_autosuggest do
  task :seed => :environment do
    # all taxons with more than two words
    Spree::Taxon.where('parent_id IS NOT NULL').each do |taxon|
      searcher = Spree::Config.searcher_class.new(:taxon => taxon.id)
      query = Spree::Suggestion.find_or_initialize_by(keywords: taxon.name)
      query.items_found = searcher.retrieve_products.size
      query.count = Spree::Autosuggest::Config[:min_count] + 1
      query.save
    end

    # all product names
    Spree::Product.find_each do |product|
      query = Spree::Suggestion.find_or_initialize_by(keywords: product.name)
      query.items_found = 1
      query.count = Spree::Autosuggest::Config[:min_count] + 1
      query.save
    end

    # spree pages extension?
  end
end
