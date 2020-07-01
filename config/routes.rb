Rails.application.routes.draw do
  root 'boards#index'
  post 'like',to: 'likes#create'
  delete 'unlike',to: 'likes#destroy'
  get 'mypage',to: 'users#me'
  get 'login',to: 'users#login'
  post 'login',to: 'sessions#create'
  delete 'logout',to: 'sessions#destroy'
  get 'win',to: 'boards#win'
  get 'hot',to: 'boards#hot'
  resources :boards
  resources :comments,only: %i[create destroy]
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
