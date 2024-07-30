Rails.application.routes.draw do
  
  resources :posts do
    resources :comments, only: [:create, :update, :destroy]
  end

  
  post 'signup', to: 'authentication#signup'
  post 'login', to: 'authentication#login'
  get '/posts',to: 'posts#show'
  get '/posts/:id',to: 'posts#index'

end 