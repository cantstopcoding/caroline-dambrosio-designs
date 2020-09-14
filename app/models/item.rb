class Item < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :users, through: :comments
  # why has many users though?
  # belongs_to :category

  scope :alpha, -> { (order(:name)) }
end


