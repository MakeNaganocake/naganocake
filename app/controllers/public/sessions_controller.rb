# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  before_action :customer_state, only: [:create]
#ログイン関係の

  # GET /resource/sign_in
  # def new
  #   super
  # end
  #new.html login画面の設定　新しい記述をしたいとき

  # POST /resource/sign_in
  # def create
  #   super
  # end
  #loginボタンを押した際の認証を行っている

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  #logoutの処理　sessionで登録された情報（値：ブラウザ上で保持できるようになっている/DB（サーバーサイド）とは関係ないところ）をクリアにしてる
  
  protected

  # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email])
    if @customer #@customerに値が入っていたら　という意味
      if @customer.valid_password?(params[:customer][:password]) && (@customer.is_deleted == true)
        #is deleted = 削除されている　= failse 削除されていない =true 削除されている
        #ここでは退会している条件式を書く　よって　true
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to about_path
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end
#   protected
# # 退会しているかを判断するメソッド
# def customer_state
#   ## 【処理内容1】 入力されたemailからアカウントを1件取得
#   @customer = Customer.find_by(email: params[:customer][:email])
#   ## アカウントを取得できなかった場合、このメソッドを終了する
#   return if !@customer
#customer_stateの処理をとりやめる
# !(=否定)@customer = @customerが空だった場合
#   ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
#   if @customer.valid_password?(params[:customer][:password])
#   @customer.valid_password?(params[:customer][:password]) && (@customer.is_deleted == false )
#     ## 【処理内容3】
#   else
#       flash[:notice] = "項目を入力"
#       redirect_to　new_customer_registration_path
#   end
# end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
