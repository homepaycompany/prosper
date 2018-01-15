Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations]

  # Marketing pages
  root to: 'pages#home'
  get 'about' => 'pages#about'
  get 'access' => 'pages#access'
  get 'contact' => 'pages#contact'
  post :subscribe, controller: :subscriptions, action: :subscribe
  post :access_request, controller: :accesses, action: :access_request

  # Studio platorm
  resources :flats, only: [:show, :index]
end
