class Public::CartItemsController < ApplicationController
 before_action :setup_cart_item!, only: %i[add_item update_item delete_item]

 def index
  @cart_items = current_customer.cart_items.all
  @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  #inject・・配列の合計を算出。配列obj.inject {|初期値, 要素|ブロック処理}
 end

 def create
   @cart_item ||= current_cart.cart_items.build(item_id: params[:item_id])
   @cart_item.quantity += params[:quantity].to_i
　if @cart_item.save
　 flash[:notice] =  '商品が追加されました。'
　 redirect_to cart_items_path
　else
　 flash[:alert] = '商品の追加に失敗しました。'
　 redirect_to item_url(params[:item_id])
 end
 
 def update
  if @cart_item.update(quantity: params[:quantity].to_i)
    flash[:notice] = 'カート内の商品が更新されました。'
  else
    flash[:alert] = 'カート内の商品の更新に失敗しました。'
  end
   redirect_to cart_items_path
 end
 
 def destroy
  if @cart_item.destroy
   flash[:notice] = 'カート内のギフトが削除されました。'
  else
   flash[:alert] = '削除に失敗しました。'
  end
  redirect_to cart_items_path
 end
 
 def destroy_all
 end
 
 
 private
 def cart_item_params
  params.require(:cart_item).permit
 end
 def setup_cart_item!
  @cart_item = current_cart.cart_items.find_by(item_id: params[:item_id])
 end
end
