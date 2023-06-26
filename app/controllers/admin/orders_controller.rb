class Admin::OrdersController < ApplicationController
def show
    #注文履歴詳細
    #@order = customers.order
    @order = Order.find(params[:id])
    @order_lists = @order.order_lists
    #Orderの情報が@orderに入っている
    #そこからorder_listsを.以下に紐づけて更に詳しい情報を取り出す
end

private

#↓これ必要な時はform with etcで情報を送ったり受け取る場合のみ？
#テーブルからデータをとってくるときもいる？
def order_params
    params.require(:order).permit(:name, :amount)
end
#viewで出したい情報
end
