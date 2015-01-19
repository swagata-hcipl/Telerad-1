Telerad::Application.routes.draw do

  root 'sessions#new'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  post 'emr_patient' => 'patients#emr'

  resources :users
  resources :patients

  resources :studies, only: [:new, :create]
  resources :comments, only: [:new, :create, :show]
  get 'upload_stream' => 'patients#upload_stream'

end
