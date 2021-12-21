Rails.application.routes.draw do
  resources :talks do
    resources :topics
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "talks#index"
end
