Rails.application.routes.draw do

  # static stuff
  root "welcome#index"
  get "/about" => "welcome#about"

  post "/links" => "links#create"

  get "/top100" => "links#top100"
  # to be safe keep this at the bottom
  get "/:code" => "links#redirector"
end
