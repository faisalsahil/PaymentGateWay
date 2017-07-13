class Invoice < ApplicationRecord
  
  attr_accessor :is_confirm_invoice
  
  
  validates :reference_number, presence: true
  validates :amount, presence: true
  validates :currency, presence: true
  validates :security_token, presence: true
  validates :auth_token, presence: true
  validates :transaction_uuid, presence: true
  validates :transaction_type, presence: true

  with_options if: :is_confirm_invoice do |br|
    br.validates :customer_firstname, presence: true
    br.validates :customer_lastname, presence: true
    
    br.validates :customer_email, presence: true
    br.validates :bill_address1, presence: true
    br.validates :bill_country, presence: true
    br.validates :client_phone, presence: true
  end

  
end