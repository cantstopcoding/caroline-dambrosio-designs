Rails.application.routes.draw do
  # add custom routes on top
  root 'sessions#home'
  
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post 'login' => 'sessions#create'

  delete '/logout' => 'sessions#destroy'
  
  # resources :categories
  resources :comments
  resources :users do 
    resources :items, only: [:new, :create, :index] #=> only: [:new, :create, :index] is called shallow routing 
  end
  resources :items do 
    resources :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
