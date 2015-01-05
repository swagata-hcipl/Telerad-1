Telerad::Application.routes.draw do
<<<<<<< HEAD
  root 'sessions#new'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
=======
  get 'comments/new'

  get 'comments/show'

  get 'studies/new'
>>>>>>> 0b3fcdc33e803c42f74b6b39fadd0424dd6a3e03

  resources :users
  resources :patients
  resources :studies, only: [:new, :create]

end
