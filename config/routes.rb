Rails.application.routes.draw do
  devise_for :users, path: "secure"
  get "up" => "rails/health#show", as: :rails_health_check
  get "about", to: "pages#about", as: :about

  resources :entries

  root "entries#index"
end
