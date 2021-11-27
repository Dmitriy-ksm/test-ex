Rails.application.routes.draw do
  root 'home#index'
  #get 'home/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #get 'items', action: :index, controller: 'items'
  get 'items/create', action: :createGet, controller: 'items'
  get 'orders', action: :index, controller: 'orders'
  post 'orders/accept', action: :accept, controller: 'orders'
  resources :items do
    member do
      post :buy
    end
  end
end
