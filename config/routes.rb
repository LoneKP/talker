Rails.application.routes.draw do
  get "/talks/:id/topics", to: redirect("/talks/%{id}")
  
  resources :talks, except: [:index] do
    resources :topics, only: [:create, :index] do
      post :upvote
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "talks#new"
end
