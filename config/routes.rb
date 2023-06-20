Rails.application.routes.draw do
  devise_for :customers,skip: [:password], controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
  }
  scope module: :public do
    get '/about' => "homes#about"
    root to: "homes#top"
    resources :items 
    resource :customers, only: [:show]
    get 'customers/information/edit' => 'customers#edit', as: 'edit_information'
    patch 'customers/information' => 'customers#update', as: 'update_information'
    post 'orders/confirm', as: 'confirm'
    get 'orders/complete'
    get 'customers/:id/quit' => 'customers#quit', as: 'quit'
    patch 'customers/:id/withdraw' => 'customers#withdraw', as: 'withdraw'
    resources :orders 
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'
    resources :cart_items
  end
  #customer
  #URL /customers/sign_in ...
  #admin
  #URL /admin/sign_in
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
      sessions: "admin/sessions"
  }
  namespace :admin do
    get '/top' => "homes#top"
    resources :items
    get 'orders/grasp/:id/show' => 'orders#show', as: 'show_grasp'
    resources :orders, only: [:show]
    resources :customers
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end