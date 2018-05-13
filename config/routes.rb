Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  # Marketing pages
  root to: 'pages#home'
  get 'pricing' => 'pages#pricing'
  get 'access' => 'pages#access'
  get 'contact' => 'pages#contact'
  post :subscribe, controller: :subscriptions, action: :subscribe
  post :access_request, controller: :accesses, action: :access_request


  # Interface
  # resources :flats, only: [:index, :show]
  # resources :wishes, only: [:create, :destroy]
  # get 'wishlist' => 'wishes#index'
  # get 'profile' => 'devise'

  # Admin interface
  mount ForestLiana::Engine => '/forest'

  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
