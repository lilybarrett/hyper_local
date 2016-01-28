Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, :only => [:show]
  get "home", to: "home#show"
  # get "events", to: "home#events"
  root 'home#show'

  resources :organizations, only:
    [:show, :new, :create, :edit, :update, :destroy] do
      resources :opportunities, only:
        [:new, :create, :destroy]
    end

  resources :opportunities, only: [:index, :show, :edit, :update] do
    resources :volunteer_lists, only: [:create]
  end

  resources :volunteer_lists, only: [:destroy]

  namespace :api do
    namespace :v1 do
      resources :volunteer_lists, only: [:create]
    end
  end

  get '/search' => 'search#index'
end
