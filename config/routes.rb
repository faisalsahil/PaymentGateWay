Rails.application.routes.draw do
  
  get 'users/index'

  devise_for :users
  get 'invoice_confirm/edit'
  get 'invoice_confirm/verify'
  put 'invoice_confirm/confirm'
  
  post 'invoice_confirm/transaction_response'
  # post 'invoice_confirm/failure'
  
  resources :users, only:[:index]
  resources :invoices do
    member do
      get :copy
    end
  end
  # get 'dashboard/index'

  root 'invoices#index'
end
