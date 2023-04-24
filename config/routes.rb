Rails.application.routes.draw do

  get 'users/edit'
  devise_for :users
  root to: "homes#top"

  get '/homes/about' => 'homes#about' ,as:'about'

  resources :books, only:[:index, :show, :destroy, :create, :edit, :update]

  resources :users, only: [:edit, :show, :update, :index]

end
