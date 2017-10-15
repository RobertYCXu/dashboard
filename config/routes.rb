Rails.application.routes.draw do
  devise_for :users, :controllers =>{ :omniauth_callbacks => 'users/omniauth_callbacks'}
  root 'static_pages#index'
  resources :boards, only: [:create, :index, :show, :destroy]
  resources :users, only: [:show]
  resources :invitations, only: [:index, :create]
  post '/boards/:id/invite', to: 'boards#invite'
  post '/create', to: 'notes#create_user_note'
  post '/boards/:id/create', to: 'notes#create_board_note'
  post '/invitations/accept', to: 'invitations#accept'
  post '/invitations/reject', to: 'invitations#reject'
  post 'boards/remove', to: 'boards#remove_member'
  resources :notes, only: [:destroy]
end
