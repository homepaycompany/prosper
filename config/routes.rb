Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'about' => 'pages#about'
  get 'access' => 'pages#access'
  get 'contact' => 'pages#contact'
  get 'jobs' => 'pages#jobs'
  post :subscribe, controller: :subscriptions, action: :subscribe
end
