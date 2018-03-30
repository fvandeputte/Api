Rails.application.routes.draw do
  resources :noticia
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/news' => 'articles#index'
  post '/news' => 'articles#create'
  get '/news/:id' => 'articles#show'
  delete 'news/:id' => 'articles#destroy'
  put '/news/:id' => 'articles#update'
  patch '/news/:id' => 'articles#update'
  # Ahora los comentarios
  get '/news/:id/comments' => 'reviews#index'
  post '/news/:id/comments' => 'reviews#create'
  get '/news/:id/comments/:id_comment' => 'reviews#show'
  delete 'news/:id/comments/:id_comment' => 'reviews#destroy'
end
