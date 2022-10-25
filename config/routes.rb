Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "authors#index"
  resources :authors, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end
end
