Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :movements
  resources :accounts
  resources :mtypes

  resources :charts do
    collection do
      get 'index'
      get 'annual_earns'
      get 'annual_status'
      get 'movements_types/:id', to: 'charts#movements_types', as: 'movements_types'
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root 'accounts#index'
end
