 class Public::OrdersController < ApplicationController
    
    def new
        @order = Order.new
        @order.address = current_customer.address
    end
    
    def confirm
        @order = Order.new(order_params)
        @cart_items = current_customer.cart_items.all
        @order.payment = params[:order][:payment]
        @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.subtotal}
        if params[:order][:distination] == "1"
          @order.postal_code = current_customer.postal_code
          @order.address = current_customer.address
          @order.name = current_customer.first_name + current_customer.last_name
        end
    end
    
    def complete
    end

    def create
      @order = Order.new(order_params)
      @order.save
      #order_listをsave
      #new=>1個のデータのみの保存　複数保存したい
      # cart_items.all.each do ||
      cart_items = current_customer.cart_items.all
      cart_items.each do |cart|
        order_list = OrderList.new
        order_list.order_id = cart.id
        order_list.item_id = cart.item_id
        order_list.amount = cart.amount
        order_list.ordered_price = cart.item.price
        #cart_item/destroy/all
      redirect_to orders_complete_path
      end
    end
    
    def index
      @orders = current_customer.orders
    end
    
    
    def show
        
    end
    
  private
    
    def order_params
      params.require(:order).permit(:payment, :address, :postal_code, :name, :customer_id, :postage, :total_payment)
    end
 end
