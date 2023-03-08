Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  
  get '/movies/:id/director', to: 'movies#show_by_director', as: 'find_same_director'
  # define the url , call the movies#controller method, as find_same_director_path
end
