Rails.application.routes.draw do
  
  
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  get 'users/index'

  devise_for :users
  get 'invoice_confirm/edit'
  get 'invoice_confirm/verify'
  put 'invoice_confirm/confirm'
  
  # post 'invoice_confirm/transaction_response'

  match 'invoice_confirm/response' => 'invoice_confirm#transaction_response', via: [:post]
  # post 'invoice_confirm/failure'
  
  resources :users, only:[:index]
  resources :invoices do
    member do
      get :copy
      get :reset
    end
    collection do
      get :failure
    end
  end
  # get 'dashboard/index'

  root 'invoices#index'
end
