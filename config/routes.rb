Rails.application.routes.draw do

  match 'auth/:provider/callback', to: 'sessions#create', as: 'signin', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  root to: 'clips#index'

  	resources :clips, only: [:create]
  resources :users, only: [:index] do  
  end

end
