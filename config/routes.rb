Rails.application.routes.draw do
  namespace :admin do
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'

    root to: 'works#index'
    resources :work_blocks
    resources :users
    resources :tags
    resources :tabs
    resources :sentences
    resources :media
    resources :likes
    resources :embeds
  end

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'terms', to: 'others#terms'
  get 'privacy', to: 'others#privacy'
  get 'how_to', to: 'others#how_to'

  root 'works#index'

  resources :works, only: %i[new create show edit update destroy] do
    resources :work_blocks
  end

  resources :users, only: %i[new create show edit update destroy]
  resources :likes, only: %i[create destroy]
end
