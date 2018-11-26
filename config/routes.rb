Rails.application.routes.draw do
  get 'preferences/index'
  get 'preferences/create'
  devise_for :users
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  root to: 'pages#home'
  get "/profile", to: 'pages#profile'
  resources :deals, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

