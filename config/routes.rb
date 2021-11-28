Rails.application.routes.draw do
  root 'items#index'
  #root 'home#index'
  #get 'home/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #get 'items', action: :index, controller: 'items'
  get 'items/create', action: :createGet, controller: 'items'
  get 'orders', action: :index, controller: 'orders'
  post 'orders/accept', action: :accept, controller: 'orders'
  delete '/orders/remove', action: :remove_position, controller: 'orders'
  get 'admin/user', action: :index, controller: 'admin_over_user'
  #get 'admin/user/:id', action: :edit, controller 'admin_over_user'
  get 'admin/user/edit/:id', to: 'admin_over_user#edit', as: 'admin_user_edit'
  post 'admin/user/edit/:id', to: 'admin_over_user#update', as: 'admin_user_update'
  #post 'admin/user/:id', action: :update, controller 'admin_over_user'
  resources :items do
    member do
      post :buy
    end
  end
end
