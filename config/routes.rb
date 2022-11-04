Rails.application.routes.draw do
  use_doorkeeper
  devise_for :authors
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  root "authors#index"
  
  resources :authors do
    resources :posts do
      resources :comments
      resources :likes, only: [:create, :destroy]
    end
  end

  
  # API ROUTES
  namespace :api do # /api
    namespace :v1 do # /api/v1
      resources :authors do # api/v1/users
        resources :posts, format: :json do # api/v1/users/:user_id/posts
          resources :comments, format: :json # api/v1/users/:user_id/posts/:post_id/comments
        end
      end
    end
  end

  scope :api do
    scope :v1 do
      use_doorkeeper do
        skip_controllers :authorizations, :applications, :authorized_applications
      end
    end
  end
end
