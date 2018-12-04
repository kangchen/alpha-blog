Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'pages#home'
  root 'pages#home'
  get 'about', to: 'pages#about'
  post 'confirm', to: 'users#confirm'

  resources :articles

  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  post 'users', to: 'users#create'
  # delete 'users', to: 'users#destroy'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
