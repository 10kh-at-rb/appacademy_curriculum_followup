Rails.application.routes.draw do

  root 'cats#index'

  resources :cats
  resources :cat_rental_requests
  patch '/cat_rental_requests/:id', :to => 'cat_rental_requests#approve'
end
