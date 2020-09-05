class User < ApplicationRecord
    has_secure_password
    
    has_many :posts
    has_many :items
    has_many :item_posts, through :items
    has_many :categories, through :posts
end
