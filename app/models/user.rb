class User < ApplicationRecord
    has_secure_password
    
    has_many :posts
    has_many :items
    has_many :item_posts, through: :items, source: :post
    # what does it mean to source?

    has_many :categories, through: :posts

end