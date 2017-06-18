Rails.application.routes.draw do
  get '/login', to: 'access#new'
  post 'login', to: 'access#create'
  get '/logout', to: 'access#destroy'

  get '/admin/index'
  get '/admin', to: 'admin#index'

  resources :users
  resources :orders
  get '/shopper/index'
  get '/shopper', to: 'shopper#index'
  root "shopper#index", as: 'root'
  resources :lineitems, :except => [:index]
  resources :carts, :except => [:index]
  resources :products

  match '*unmatched_route', to: 'application#not_found', via: :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
