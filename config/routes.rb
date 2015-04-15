Rails.application.routes.draw do
  get 'users/new'

  root 'home#index'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

end
