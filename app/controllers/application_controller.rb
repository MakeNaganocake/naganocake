class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?
    def after_sign_out_path_for(resource)
      root_path
    end

    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
    end
# protect_from_forgery with: :exception

# helper_method :current_cart

# def current_cart
#   if current_customer
#     #codeforlink customer&cart
#     current_cart = current_customer.cart || current_customer.create_cart
#   else
#     #codeforlinkwith session
#     current_cart = Cart.find_by(id: session[:cart_id]) || Cart.create
#     session[:cart_id] ||= current_cart.id
#   end
#   current_cart
# end
end
