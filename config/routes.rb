Rails.application.routes.draw do

  match 'auth/:provider/callback', to: 'sessions#create', as: 'signin', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  match 'clips/next', to: 'clips#next', as: 'next_clip', via: [:get]
  match 'votes/create', to: 'votes#create', as: 'create_vote', via: [:post]

  match 'cc_apikey', to: 'application#apikey', as: 'cc_apikey', via: [:get]

  root to: 'clips#index'

  resources :clips, only: [:create]
  resources :users, only: [:index] do
  end

end
