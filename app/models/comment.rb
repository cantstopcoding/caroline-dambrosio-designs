class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :content, presence: true
  validates :content, :length => { :maximum => 300 }

  scope :order_recent_date, -> { order 'created_at DESC' }
end
