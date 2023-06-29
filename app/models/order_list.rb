class OrderList < ApplicationRecord
    belongs_to :order
    belongs_to :item
    def add_tax_ordered_price
           (self.ordered_price * 1.10).round
           #self = OrderListのこと 今いるモデルのこと
    end
    def subtotal
        self.add_tax_ordered_price * self.amount
    end
end
