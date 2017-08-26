class CreateProducts < ActiveRecord::Migration

  def self.up
    create_table :products do |t|
      t.string  :name
      t.text    :description
      t.text    :ingredients
      t.string  :image
      t.timestamps
    end
    Product.create_translation_table! name: :string, description: :text, ingredients: :text
  end

  def self.down
    drop_table :products
    Product.drop_translation_table!
  end
end
