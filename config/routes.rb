Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :invoices, only: [:index, :show, :create, :update]
  resources :borrowers, only: [:index]
end
