Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: 'homepages#index'
  
  resources :trips
  
  # ? TODO Do we need some kind of patch to say trips are complete ?
  
  resources :drivers do
    resources :trips, only: [:index, :new]
  end
  
  # TODO need some kind of patch to say if a driver is active or not
  
  resources :passengers do
    resources :trips, only: [:index, :new]
  end
  
  
  # Example routes from Task List
  ## routes on the collection
  # get '/tasks', to: 'tasks#index', as: 'tasks' #lists all tasks
  # get '/tasks/new', to: 'tasks#new', as: 'new_task' #gets form for a new task
  # post '/tasks', to: 'tasks#create'
  
  # # routes on individual tasks
  # get '/tasks/:id', to: 'tasks#show', as: 'task' #shows details for one task
  # get '/tasks/:id/edit', to: 'tasks#edit', as: 'edit_task' #brings up edit form to edit one task
  # patch '/tasks/:id', to: 'tasks#update'
  # delete '/tasks/:id', to: 'tasks#destroy'
  
  ## Not covered by resources
  
  # patch '/tasks/:id/mark_done', to: 'tasks#mark_done', as: 'mark_done'
  
end
