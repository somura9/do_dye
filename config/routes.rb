Rails.application.routes.draw do
  root 'works#index'
  resources :works, only: %i[new create show edit update destroy]

end
