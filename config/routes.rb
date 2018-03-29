Rails.application.routes.draw do
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/news' => 'articles#index'
  post '/news' => 'articles#create'
end
