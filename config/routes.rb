Rails.application.routes.draw do
  root "homes#top"
  get "home/about" => "homes#about"
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    member do
      get :followings
      get :followers
    end
  end
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
end
