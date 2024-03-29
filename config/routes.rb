Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
  get '/manifest.json', to: 'home#manifest'

  resources :events

  resources :events_hosts do
    member { get :confirmation_message}
    member { get :confirm}
    member { get :create_admin_user}
  end

  resources :locations
  resources :contacts
  resources :socials
end
