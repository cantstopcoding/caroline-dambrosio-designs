class Post < ApplicationRecord
  belongs_to :user
  has_many :items
  has_many :users, through: :items
  # why has many users though?

  # belongs_to :category
end


