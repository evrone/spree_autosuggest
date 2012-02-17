class Spree::Suggestion < ActiveRecord::Base
  validates :keywords, :presence => true

  def self.relevant(keyword, max=5, count_weight=2, items_found_weight=1)
    select(:keywords).
      where("keywords LIKE ? AND items_found != 0", keyword + '%').
      order("(#{count_weight}*count + #{items_found_weight}*items_found) DESC").
      limit(max)
  end

end
