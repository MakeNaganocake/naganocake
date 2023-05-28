class Item < ApplicationRecord
    has_one_attached :image
    
    has_many :cart_items
    has_many :order_items
    def taxin_price
        price*1.1
    end
end
