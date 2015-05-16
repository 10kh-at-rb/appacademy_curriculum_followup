Rails.application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: [:destroy] do
    resource :post, only: [:new]
  end
  resources :posts, except: [:index, :show, :new]
end
