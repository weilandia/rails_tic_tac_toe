Rails.application.routes.draw do
  root 'game#index'
  put '/game/update', to: 'game#update'
  get '/game/new', to: 'game#new'
end
