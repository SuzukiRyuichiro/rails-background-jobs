Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/sent', to: "pages#sent", as: :sent
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
