Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "authors#index"
  resources :authors do
    resources :posts do
      resources :comments
      resources :likes
    end
  end
end
