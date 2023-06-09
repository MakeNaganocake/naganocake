class Public::CartItemsController < ApplicationController
 before_action :setup_cart_item!, only: %i[add_item update_item delete_item]

 def index
  
  @cart_items = current_customer.cart_items.all
  @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  #inject・・配列の合計を算出。配列obj.inject {|初期値, 要素|ブロック処理}
 end

 def create
  #理解しとくとこ
   cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
   #cart_items -> current_customer に対して使っている。sessionの情報もcurrent_customer
   #find_by(カラム名: 値) -> 基本構文
   #cart_itemsの中のitem_id -> 何の値がcartitemに入っているか
  
   if cart_item #中身があるか確認(カートアイテムがあったら)　if +　変数　=> 変数があったら。
      cart_item.amount += CartItem.new(cart_item_params).amount #追加の動作
      cart_item.save
      redirect_to cart_items_path
   else
      @cart_item = CartItem.new(cart_item_params)#新規登録(formから値を受け取るだけ
      @cart_item.customer_id = current_customer.id #?アソシエーション外部キー"誰のカート"
    if @cart_item.save!
     flash[:notice] =  '商品が追加されました。'
     redirect_to cart_items_path
    else
      flash[:alert] = '商品の追加に失敗しました。'
      redirect_to item_path(params[:cart_item][:item_id])
    end
   end
 end
 def update
   @cart_item = CartItem.find(params[:id])
   if @cart_item.update(amount: params[:cart_item][:amount].to_i)
    #特定のカラムからの情報を取り出す（）の中身
     flash[:notice] = 'カート内の商品が更新されました。'
   else
     flash[:alert] = 'カート内の商品の更新に失敗しました。'
   end
    redirect_to cart_items_path
 end
 
 def destroy
  @cart_item = CartItem.find(params[:id])
  if @cart_item.destroy
   flash[:notice] = 'カート内の商品が削除されました。'
  else
   flash[:alert] = '削除に失敗しました。'
  end
  redirect_to cart_items_path
 end
 
 def destroy_all
  #CartItem.destroy_all
  current_customer.cart_items.destroy_all
  redirect_to cart_items_path, notice: 'カートが空になりました'
 end
 
 
 private
 def cart_item_params
  params.require(:cart_item).permit(:amount, :item_id)
 end
 def setup_cart_item!
  @cart_item = current_cart.cart_items.find_by(item_id: params[:item_id])
 end
end
