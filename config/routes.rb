Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'about' => 'pages#about'
  get 'jobs' => 'pages#jobs'
  get 'access' => 'pages#access'
end
