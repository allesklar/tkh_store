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

  scope :alphabetically, -> { order('name') }
  scope :by_recently_created, -> { order('created_at desc') }
  scope :by_recently_published, -> { order('published_at desc') }
  scope :by_recently_updated, -> { order('updated_at desc') }

  def published?
    published_at.present? ? true : false
  end

end
