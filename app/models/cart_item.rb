class CartItem < ApplicationRecord
    belongs_to :order
    belongs_to :item
    belongs_to :customer
    
    def sum_of_price
        item.taxin_price * quantity
    end
    
end
