Rails.application.routes.draw do
    
  #customer
  #URL /customers/sign_in ...
  devise_for :customers,skip: [:password], controllers: {
      registrations: "public/registration",
      sessions: 'public/sessions'
  }
  #admin
  #URL /admin/sign_in
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
      sessions: "admin/sessions"
  }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
scope module: :public do
  get '/about' => "homes#about"
root to: "homes#top"
end
end