class Order < ApplicationRecord
    belongs_to :customer
    has_many :order_lists
       enum payment: { credit_card: 0, transfer: 1 }
end