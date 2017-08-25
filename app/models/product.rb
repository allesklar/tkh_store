class Product < ActiveRecord::Base

  tkh_searchable
  def self.tkh_search_indexable_fields
    indexable_fields = {
      name: 8,
      description: 3,
      ingredients: 4
    }
  end

  translates :name, :description, :ingredients

  # in tkh_illustrations gem
  mount_uploader :image, ImageUploader

  def to_param
    name ? "#{id}-#{name.to_url}" : id
  end

  scope :by_recent, -> { order('created_at desc') }
  scope :alphabetically, -> { order('name') }

end
