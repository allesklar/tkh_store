class Category < ActiveRecord::Base

  has_many :products

  translates :name

  def to_param
    name ? "#{id}-#{name.to_url}" : id
  end

  scope :alphabetically, -> { order('name') }
  scope :by_position, -> { order('position, id') }

end
