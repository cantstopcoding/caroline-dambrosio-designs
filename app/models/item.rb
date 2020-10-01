class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments, source: :user

  # delegate :name, to: :category

  validates :name, :image_url, :price, :description, presence: true
  # form for field creates a fild_with_errors and the page must be rendered, in addition with presence: true
  validate :too_many_items

  scope :alpha, -> { (order(:name)) }
  scope :most_comments, -> { left_joins(:comments).group('items.id').order('count(comments.item_id) desc') } 
  # :comments is AREL syntax 'items.id' is query syntax and it's using plural table (items) name and column name (id)
  scope :filter_category, -> (id) {where("category_id = ?", id)}

  def self.search(params)
    left_joins(:comments).where("LOWER(items.name) LIKE :term OR LOWER(items.name) LIKE :term OR LOWER(comments.content) LIKE :term", term: "%#{params}%")
  end

  def category_attributes=(attr)
    self.category = Category.find_or_create_by(attr) if !attr[:name].blank?
  end

  def too_many_items
    todays_items = user.items.select do |item|
      item.created_at.try(:to_date) == Date.today
    end
    if todays_items.size > 20
      errors.add(:item_id, "can't post more than 20 times a day.")
    end
  end 
end


