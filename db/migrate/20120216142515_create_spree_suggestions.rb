class CreateSpreeSuggestions < ActiveRecord::Migration
  def change
    create_table :spree_suggestions do |t|
      t.string :keywords
      t.integer :count
      t.integer :items_found
      t.timestamps
    end

    add_index :spree_suggestions, [:keywords, :count, :items_found]
  end
end
