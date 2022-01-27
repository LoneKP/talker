Rails.application.routes.draw do
  require "sidekiq/web"

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
  end if Rails.env.production?

  mount Sidekiq::Web, at: "/sidekiq"

  get "/talks/:id/topics", to: redirect("/talks/%{id}")
  get "/talks", to: redirect("/talks/new")
  get "/talks/:id/current_visitor", to: "visitors#current_visitor", as: :current_visitor
  
  resources :talks do
      post :update_current_topic
    resources :topics, only: [:create, :index, :update] do
      post :upvote
    end
    resources :visitors, only: [:new, :create] do
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "talks#index"
end
