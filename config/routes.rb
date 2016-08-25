Rails.application.routes.draw do

  # static stuff
  root "welcome#index"
  get "/about" => "welcome#about"

  post "/links" => "links#create"

  # to be safe keep this at the bottom
  get "/:code" => "links#redirector"
end
