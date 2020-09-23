class Category < ApplicationRecord
    has_many :items
    has_many :users, through: :items 

    def items_count
        items.count
    end
end
