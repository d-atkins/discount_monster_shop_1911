# frozen_string_literal: true

Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  # resources :merchants, except: [:destroy]
  get '/merchants', to: 'merchants#index'
  get '/merchants/new', to: 'merchants#new'
  post '/merchants', to: 'merchants#create'
  get '/merchants/:id', to: 'merchants#show', as: 'merchant'
  get '/merchants/:id/edit', to: 'merchants#edit'
  patch '/merchants/:id', to: 'merchants#update'


  get '/merchants/:merchant_id/items', to: 'merchant_items#index'

  # resources :items, only: %i[index show] do
    # resources :reviews, only: %i[new create]
  # end
  get '/items', to: 'items#index', as: 'item'
  get '/items/:id', to: 'items#show'
  get '/items/:item_id/reviews/new', to: 'reviews#new'
  post '/items/:item_id/reviews', to: 'reviews#create'

  namespace :profile do
    get '/', to: 'users#show'
    get '/edit', to: 'users#edit'
    patch '/user', to: 'users#update'
    get '/edit/pw', to: 'security#edit'
    patch '/user/pw', to: 'security#update'

    # resources :orders, only: [:index, :show, :new, :create, :update]
    get '/orders', to: 'orders#index'
    get '/orders/new', to: 'orders#new'
    post '/orders', to: 'orders#create'
    get '/orders/:id', to: 'orders#show', as: 'order'
    patch '/orders/:id', to: 'orders#update'
  end

  namespace :admin do
    get '/', to: 'dashboard#index'
    get '/users/:id/orders', to: 'user_orders#index'
    get '/users/:id/orders/:id', to: 'user_orders#show'
    patch '/users/:id/orders/:id', to: 'user_orders#update'
    get '/merchants/:id/orders/:id', to: 'merchant_orders#show'

    # resources :users, only: %i[index show]
    get '/users', to: 'users#index'
    get '/users/:id', to: 'users#show', as: 'user'

    # resources :orders, only: [:update]
    patch '/orders/:id', to: 'orders#update'

    # resources :merchants, only: %i[index show update]
    get '/merchants', to: 'merchants#index'
    get '/merchants/:id', to: 'merchants#show', as: 'merchant'
    patch '/merchants/:id', to: 'merchants#update'
  end

  namespace :merchant do
    get '/', to: 'dashboard#index'
    get '/:merchant_id/items/new', to: 'items#new'
    post '/:merchant_id/items', to: 'items#create'
    patch '/items/:id/toggle', to: 'toggle#update'

    # resources :items, only: %i[index show edit update destroy]
    get '/items', to: 'items#index'
    get '/items/:id', to: 'items#show', as: 'item'
    get '/items/:id/edit', to: 'items#edit'
    patch '/items/:id', to: 'items#update'
    delete '/items/:id', to: 'items#destroy'

    # resources :orders, only: [:show]
    get '/orders/:id', to: 'orders#show', as: 'order'

    # resources :item_orders, only: [:update]
    patch '/item_orders/:id', to: 'item_orders#update', as: 'item_order'

    # resources :discounts, only: [:index, :show, :new, :create, :update]
    get '/discounts', to: 'discounts#index'
    get '/discounts/new', to: 'discounts#new'
    post '/discounts', to: 'discounts#create'
    get '/discounts/:id', to: 'discounts#show', as: 'discount'
    patch '/discounts/:id', to: 'discounts#update'
  end

  # resources :reviews, only: [:edit, :update, :destroy]
  get '/reviews/:id/edit', to: 'reviews#edit'
  patch '/reviews/:id', to: 'reviews#update'
  delete '/reviews/:id', to: 'reviews#destroy'

  post '/cart/:item_id', to: 'cart#add_item'
  get '/cart', to: 'cart#show'
  delete '/cart', to: 'cart#empty'
  delete '/cart/:item_id', to: 'cart#remove_item'
  patch '/cart/:item_id', to: 'cart#edit'

  # resources :orders, only: [:new, :create, :show]
  get '/orders/new', to: 'orders#new'
  post '/orders', to: 'orders#create'
  post '/orders/:id', to: 'orders#show'
end
