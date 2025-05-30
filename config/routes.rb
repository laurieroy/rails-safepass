Rails.application.routes.draw do
  devise_for :users, path: "secure"

  get "up" => "rails/health#show", as: :rails_health_check
  get "about", to: "pages#about", as: :about

  namespace :api do
    namespace :v1 do
      post :auth, to: "auth#create"
      resources :entries
    end
  end

  resources :entries

  root "entries#index"
end
