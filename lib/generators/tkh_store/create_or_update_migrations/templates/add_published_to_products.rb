class AddPublishedToProducts < ActiveRecord::Migration
  def change
    add_column :products, :published_at, :datetime, default: nil
    add_index :products, :published_at
  end
end
