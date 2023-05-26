class Public::CartItemsController < ApplicationController

 def index
  @cart_items = current_customer.cart_items.all
  @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  #inject・・配列の合計を算出。配列obj.inject {|初期値, 要素|ブロック処理}
 end

 def update
 end
 
 def destroy
 end
 
 def destroy_all
 end
 
 def create
 end
 
end
