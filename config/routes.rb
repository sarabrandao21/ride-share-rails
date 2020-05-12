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
    resources :trips, only: [:index, :create, :new]
  end
  
  
end
