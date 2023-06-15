class Admin::HomesController < ApplicationController
    def top
        @order_lists = Order.all
    end
end
