class Spree::SuggestionConfiguration < Spree::Preferences::Configuration
  preference :rows_to_display,    :integer, default: 5
  preference :rows_from_db,       :integer, default: 15
  preference :count_weight,       :integer, default: 2
  preference :items_found_weight, :integer, default: 1
  preference :min_count,          :integer, default: 5
  preference :field,              :string,  default: 'keywords'
end
