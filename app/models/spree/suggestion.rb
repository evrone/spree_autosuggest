class Spree::Suggestion < ActiveRecord::Base
  validates :keywords, :presence => true

  def self.relevant(keyword)
    config = Spree::Suggestion::Config

    select(:keywords).
      where("keywords LIKE ? AND items_found != 0", keyword + '%').
      order("(#{config.count_weight}*count + #{config.items_found_weight}*items_found) DESC").
      limit(config.rows_from_db)
  end

end
