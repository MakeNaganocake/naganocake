 class Public::OrdersController < ApplicationController
    
    def new
        @order = Order.new
        @order.address = current_customer.address
        #↓URLで直接入力を無効にして情報入力画面に行けない記述
        #cartitemが空だったらカートに戻る
        @cart_items = current_customer.cart_items
        if @cart_items == []
          redirect_to cart_items_path
        end
    end
    
    def confirm
        @order = Order.new(order_params)
        @cart_items = current_customer.cart_items.all
        @order.payment = params[:order][:payment]
        #パラメーターから直接情報をとる記述
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
      #アソシエーションを始めるための記述
      cart_items.each do |cart_item|
        #cart_items(table/複数の情報)の中から|cart_item|1件の情報を取り出して
        #3商品の情報が必要なら３個分を取得する(繰り返し/each)
        order_list = OrderList.new
        order_list.order_id = @order.id
        #上記で定義した@orderと紐づける/saveした情報
        #1:N(多)の関係の時、親と子になり"子の側"はどこに紐づいているのか
        #(親側)を記述する必要がある。リレーション。外部キー
        order_list.item_id = cart_item.item_id
        order_list.amount = cart_item.amount
        order_list.ordered_price = cart_item.item.price
        order_list.save
      end
      cart_items.destroy_all
      redirect_to orders_complete_path
    end
    
    def index
      @orders = current_customer.orders
    end
    
    def show
      @order = Order.find(params[:id])
    end
    
  private
    
    def order_params
      params.require(:order).permit(:payment, :address, :postal_code, :name, :customer_id, :postage, :total_payment)
    end
 end
# params => parameter全体{この中身}
# require(:order) => このテーブルが存在するかどうかの確認
# permit => (:  , :  ,  )パラメーターの中に入ってていいもの
# つまりここの情報だけでいいよと受け渡しする

