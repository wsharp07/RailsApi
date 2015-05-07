Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'users/new'

  root 'home#index'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  get     'rma'    => 'rma#index'
  get     'rma/new'=> 'rma#create'

  get    'signup' => 'users#new'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
