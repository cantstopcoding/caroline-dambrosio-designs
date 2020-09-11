Rails.application.routes.draw do
  # add custom routes on top
  root 'sessions#home'
  
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post 'login' => 'sessions#create'

  delete '/logout' => 'sessions#destroy'
  
  # it's important that this resource was on top, but why?
  resources :items do 
    resources :comments
  end

  # resources :categories
  resources :comments
  # set it up so users only have index 
  resources :users do 
    resources :items, shallow: true #=> only: [:new, :create, :index]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
