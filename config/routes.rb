Rails.application.routes.draw do
  root 'games#create'
  resources :games, only: [:show, :update]
end
