Rails.application.routes.draw do
  namespace :admin do
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'

    root to: 'work_tags#index'
    resources :work_tags
    resources :work_blocks
    resources :works
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

  root 'works#index'

  resources :works, only: %i[new create show edit update destroy] do
    resources :work_blocks
  end

  resources :users, only: %i[new create show edit update destroy]
end
