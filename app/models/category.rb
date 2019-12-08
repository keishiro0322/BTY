class Category < ApplicationRecord
  has_many :category_maps, dependent: :destroy
  has_many :posts, through: :category_maps
end
