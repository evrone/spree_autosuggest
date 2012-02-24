class Spree::Suggestion < ActiveRecord::Base
  validates :keywords, :presence => true

  def self.relevant(term)
    config = Spree::Suggestion::Config

    select(:keywords).
      where("count >= ?", config.min_count).
      where("items_found != 0").
      where("keywords LIKE ? OR keywords LIKE ?", term + '%', KeySwitcher.switch(term) + '%').
      order("(#{config.count_weight}*count + #{config.items_found_weight}*items_found) DESC").
      limit(config.rows_from_db)
  end

end
