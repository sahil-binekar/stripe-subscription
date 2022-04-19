Rails.application.routes.draw do
  resources :posts
  root to: 'posts#index'
  # resources :checkout
  # do
    post 'checkout/create', to: 'checkout#create'
    get 'checkout/success', to: 'checkout#success'
    get 'checkout/cancel', to: 'checkout#cancel'
    delete 'checkout/unsubscrib', to: 'checkout#destroy'
  # end
  devise_for :users
  resources :webhooks, only: [:create]
end
