Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # resources :users, only: [:show] do
  #   resources :meals, only: [ :index, :show ]
  #   resources :groceries_lists, only: [:show]
  # end

  get "/profile", to: "pages#profile"

  namespace :profile do
    resources :meals, only: [ :index, :show ]
    resources :groceries_lists, only: [:show]
    resources :plans, only: [:index, :show, :new, :create]
  end

end
