Rails.application.routes.draw do
  
  get 'invoice_confirm/edit'
  get 'invoice_confirm/verify'
  put 'invoice_confirm/confirm'
  
  post 'invoice_confirm/success'
  # post 'invoice_confirm/failure'
  

  resources :invoices
  # get 'dashboard/index'

  root 'invoices#index'
end
