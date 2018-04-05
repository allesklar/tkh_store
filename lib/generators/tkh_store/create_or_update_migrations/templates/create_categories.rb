class CreateCategories < ActiveRecord::Migration

  def self.up
    create_table :categories do |t|
      t.string  :name
      t.integer :position,  default: 0
      t.timestamps
    end
    Category.create_translation_table! name: :string

    add_column :products, :category_id, :integer
  end

  def self.down
    drop_table :categories
    Category.drop_translation_table!

    remove_column :products, :category_id
  end
end
