Rails.application.routes.draw do
  
  resources :talks do
    resources :topics, only: :create do
      post :upvote
    end
    post :change_state
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "talks#index"
end
