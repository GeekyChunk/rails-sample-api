Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post "/api/auth/register/", to: "auth#create"
  post "/api/auth/login/", to: "auth#login"
  post "/api/auth/me/", to: "auth#me"


end
