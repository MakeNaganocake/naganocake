 class Public::OrdersController < ApplicationController
    
    def new
        @order = Order.new
        @order.address = current_customer.address
    end
    
    def confirm
        @order = Order.new(order_params)
        @cart_items = current_customer.cart_items.all
        @order.payment = params[:order][:payment]
        if params[:order][:distination] == "1"
          @order.postal_code = current_customer.postal_code
          @order.address = current_customer.address
          @order.name = current_customer.first_name + current_customer.last_name
        end
    end
    
    def complete
    
    end

    def create
    end
    
    def index
        
    end
    
    def show
        
    end
    
  private
    
    def order_params
      params.require(:order).permit(:payment, :address, :postal_code, :name)
    end
 end
