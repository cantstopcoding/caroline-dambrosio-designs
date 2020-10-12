Rails.application.routes.draw do
  # add custom routes on top
  root 'sessions#home'
  
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post 'login' => 'sessions#create'

  delete '/logout' => 'sessions#destroy'

  # omniauth callback route
  get "/auth/:provider/callback" => 'sessions#omnilogin'
  
  concern :most_commented_items do 
      get 'most-commented-items' => 'items#most_commented_items'
  end

  concerns :most_commented_items

  # it's important that this resource was on top, but why?
  resources :items do 
    resources :comments #=> maybe do , shallow: true
  end

  resources :comments
  # set it up so users only have index 
  resources :users, concerns: :most_commented_items do 
    resources :items, only: [:index]
  end

  resources :categories, only: [:index, :show]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
