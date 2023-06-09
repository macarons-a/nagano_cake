Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords],  controllers: {
    registrations: "public/registrations",
    sessions:      'public/sessions'
  }

  namespace :admin do
    get '/' => 'homes#top'
    resources :items,       only: %i(index show new create edit update)
    resources :genres,      only: %i(index create edit update)
    resources :customers,   only: %i(index show edit update) do
      get 'orders' => "orders#index"
    end
    resources :orders,      only: %i(show update)
    resources :order_items, only: %i(update)
  end

  scope module: :public do
    root :to                             =>  'homes#top'
    get    '/about'                      =>  'homes#about'
    get    'customers/withdraw_confirm'  =>  'customers#withdraw_confirm'
    patch  'customers/withdraw'          =>  'customers#withdraw'
    delete 'cart_items/destroy_all'      =>  'cart_items#destroy_all'
    post   'orders/confirm'              =>  'orders#confirm'
    get    'orders/complete'             =>  'orders#complete'
    get    '/customers'                  =>  'customers#show'
    get    'customers/information/edit', to: 'customers#edit',   as: 'edit_customer'
    patch  'customers/information',      to: 'customers#update', as: 'update_customer'
    get    'items/search'                =>  'items#search'

    resources :items,       only: %i(index show)
    resources :cart_items,  only: %i(index update destroy create)
    resources :orders,      only: %i(new create index show)
    resources :addresses,   only: %i(create index edit update destroy)
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
