Rails.application.routes.draw do
  devise_for :users
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  root to: 'pages#home'
  get "/profile", to: 'pages#profile'
  resources :deals, only: [:index, :show]
  get "deals/:id/loaded", to: 'deals#show_loaded', as: :show_loaded
  resources :preferences, only: [:create]
  get 'deals/:id/chart/', to: 'deals#chart', as: :chart
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

