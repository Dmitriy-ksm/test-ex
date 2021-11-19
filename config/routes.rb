Rails.application.routes.draw do
  root 'home#index'
  #get 'home/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'items', action: :index, controller: 'items'
  get 'items/create', action: :createGet, controller: 'items'
  resources :items
end
