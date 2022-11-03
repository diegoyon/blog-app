Rails.application.routes.draw do
  devise_for :authors
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "authors#index"
  post '/auth/login', to: 'authentication#login'
  resources :authors do
    resources :posts do
      resources :comments
      resources :likes, only: [:create, :destroy]
    end
  end
end
