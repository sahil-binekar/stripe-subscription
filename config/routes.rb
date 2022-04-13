Rails.application.routes.draw do
  resources :posts
  root to: 'posts#index'
  # resources :checkout 
  # do
    post 'checkout/create', to: 'checkout#create'
    delete 'checkout/unsubscrib', to: 'checkout#destroy'
  # end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :webhooks, only: [:create]
end
