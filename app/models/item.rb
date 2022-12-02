class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :image, presence: true
  validates :name,        presence: true
  validates :nickname,        presence: true
  validates :info,        presence: true
  validates :nickname,        presence: true
  validates :category_id ,        presence: true
  validates :sales_status_id,        presence: true
  validates :shipping_fee_status_id,        presence: true
  validates :prefecture_id,        presence: true
  validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}, presence: true
end
