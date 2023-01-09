Rails.application.routes.draw do
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  root 'works#index'
  
  resources :works, only: %i[new create show edit update destroy] do
    resources :work_blocks
  end

  resources :users, only: %i[new create show edit update destroy]
end
