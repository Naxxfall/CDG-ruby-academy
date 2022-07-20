Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # get '/posts', to: 'posts#index'
  root "posts#index"
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resource :comments, only: [:create, :update, :destroy]
  get '/feed', to: 'posts#subscriptions'
  resource :likes, only: [:create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users, only: [:index, :show]
  resources :followers, only: [:create, :destroy]
end
