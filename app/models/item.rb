class Item < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :users, through: :comments
  # why has many users though?
  # belongs_to :category

  scope :alpha, -> { (order(:name)) }
  scope :most_comments, -> { left_joins(:comments).group('items.id').order('count(comments.item_id) desc') } 
  # :comments is AREL syntax 'items.id' is query syntax and it's using plural table (items) name and column name (id)
end


