Rails.application.routes.draw do

  # static stuff
  root "welcome#index"
  get "/about" => "welcome#about"

end
