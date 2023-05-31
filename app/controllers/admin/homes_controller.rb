class Admin::HomesController < ApplicationController
    def top
        @order_list = OrderList.all
    end
end
