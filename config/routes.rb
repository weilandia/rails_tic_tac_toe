Rails.application.routes.draw do
  get 'moves/index'

  root 'games#create'
  resources :games, only: [:show, :update] do
    resources :moves, only: [:index]
  end
end
