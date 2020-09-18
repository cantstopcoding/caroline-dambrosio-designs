class User < ApplicationRecord
    has_secure_password
    
    has_many :items
    has_many :comments
    has_many :commented_items, through: :comments, source: :item
    # what does it mean to source?

    has_many :categories, through: :items

    validates :first_name, :last_name, :username, :email, presence: true
    validates :email, uniqueness: true

end
