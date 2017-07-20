Rails.application.routes.draw do
  
  get 'invoice_confirm/edit'
  get 'invoice_confirm/verify'
  put 'invoice_confirm/confirm'
  
  post 'invoice_confirm/response'
  # post 'invoice_confirm/failure'
  

  resources :invoices do
    member do
      get :copy
    end
  end
  # get 'dashboard/index'

  root 'invoices#index'
end
