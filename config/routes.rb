Rails.application.routes.draw do

  resources :request_types
  mount Judge::Engine => '/judge'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'users/new'

  root 'home#index'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'


  get    'signup' => 'users#new'

  get    'rmas/manage' => 'rmas#manage'
  get    'time_offs/manage' => 'time_offs#manage'

  get    'hardware_types/read' => 'hardware_types#read'

  resources :users
  resources :rmas
  resources :time_offs
  resources :hardware_types
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
