class Post < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :category_maps, dependent: :destroy
  has_many :categories, through: :category_maps

  # accepts_nested_attributes_for :comments, allow_destroy: true


  scope :order_by_created_at, -> {order(created_at: :desc)}


end
