Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  get 'pages/home' , to:'pages#home'
  resources :projects do
    resources :bugs do
      resources :comments, only: [:create]
    end
    post 'add_users', on: :member
    delete 'remove_users', on: :member
  end
end
