Rails.application.routes.draw do
  root 'game#create'
  get '/game', to: 'game#index'
  put '/game', to: 'game#update'
end
