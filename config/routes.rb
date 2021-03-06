Rails.application.routes.draw do

  # static stuff
  root "welcome#index"
  get "/about" => "welcome#about"

  resources :links, only: [:create, :show] do
    resources :views, only: [:index, :show]
  end

  get "/top100" => "links#top100"
  # to be safe keep this at the bottom
  get "/:code" => "links#redirector"
end
