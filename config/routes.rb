Rails.application.routes.draw do
  resources :posts
  root to: 'posts#index'
  # resources :checkout
  # do
    post 'checkout/create', to: 'checkout#create'
    get 'checkout/succeed', to: 'checkout#succeed'
    get 'checkout/cancelled', to: 'checkout#cancelled'
    delete 'checkout/unsubscrib', to: 'checkout#destroy'
  # end
  devise_for :users
  resources :webhooks, only: [:create]
  get 'webhooks/success', to: 'webhooks#success'
  get 'webhooks/failed', to: 'webhooks#failed'
end
