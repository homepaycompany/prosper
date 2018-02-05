Rails.application.routes.draw do
  mount ForestLiana::Engine => '/forest'
  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  # Marketing pages
  root to: 'pages#home'
  get 'about' => 'pages#about'
  get 'access' => 'pages#access'
  get 'contact' => 'pages#contact'
  post :subscribe, controller: :subscriptions, action: :subscribe
  post :access_request, controller: :accesses, action: :access_request


  resources :flats, only: [:index, :show]

  resources :wishes, only: [:create, :destroy]
  get 'wishlist' => 'wishes#index'

  get 'profile' => 'devise'
end
