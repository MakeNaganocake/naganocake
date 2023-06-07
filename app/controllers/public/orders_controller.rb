class Public::OrdersController < ApplicationController

def new
    @order = Order.new
    @order.address = current_customer.address
end

def confirm
  @order = Order.new(order_params)
  @order.postal_code = current_customer.postal_code
  @order.address = current_customer.address
  @order.name = current_customer.first_name + current_customer.last_name
end

def complete
    
end

def create
    cart_items = current.customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
        cart_items.each do |cart|
            #order_itemにも一緒にデータを保存
            order_item = OrderItem.new
            order_item.item_id = cart.item_id
            order_item.order_id = @order.id
            order_item.order_quantity = cart.quantity
            order_item.order_price = cart.item.price
            order_item.save
        end
        redirect_to customer_show_path
        cart_items.destroy_all
    else
        @order = Order.new(order.params)
        render :new
    end
end

def index
end

def show
end

private

def order_params
    params.require(:order).permit(:payment_method, :name, :address, :total_price, :postal_code)
end

end
