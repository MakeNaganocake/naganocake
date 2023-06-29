class Order < ApplicationRecord
    belongs_to :customer
    has_many :order_lists
       enum payment: { credit_card: 0, transfer: 1 }
       def add_tax_ordered_price
           (self.ordered_price * 1.10).round
       end
end