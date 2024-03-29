Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
  get '/manifest.json', to: 'home#manifest'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  resources :events

  resources :events_hosts do
    member { get :confirmation_message}
    member { get :confirm}
    member { get :create_admin_user}
    member { get :settings}
  end

  resources :locations
  resources :contacts
  resources :socials
end
