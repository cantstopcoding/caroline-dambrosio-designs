Rails.application.routes.draw do
  # add custom routes on top
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  
  resources :categories
  resources :items
  resources :users
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
