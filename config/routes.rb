Rails.application.routes.draw do
  scope module: :public do
    get '/about' => "homes#about"
    root to: "homes#top"
    resources :items 
    resource :customers 
    resources :orders 
    post 'orders/confirm', as: 'confirm'
    get 'orders/complete'
    resources :cart_items
  end
  #customer
  #URL /customers/sign_in ...
  devise_for :customers,skip: [:password], controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
  }
  #admin
  #URL /admin/sign_in
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
      sessions: "admin/sessions"
  }
  namespace :admin do
    get '/top' => "homes#top"
    resources :items
    resources :orders
    resources :customers
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end