class AddPositionToProducts < ActiveRecord::Migration
  def change
    add_column :products, :position, :integer, default: 0
  end
end
