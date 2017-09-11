class Invoice < ApplicationRecord
  include AASM
  attr_accessor :is_confirm_invoice, :contact_same_as_above, :is_terms_and_conditions_accepted, :terms_condition
  
  validates :consumer_id, presence: true
  validates :reference_number, presence: true
  validates :amount, presence: true
  validates :currency, presence: true
  validates :security_token, presence: true
  validates :auth_token, presence: true
  validates :transaction_uuid, presence: true
  validates :transaction_type, presence: true

  with_options if: :is_confirm_invoice do |br|
    br.validates :bill_to_forename, presence: true
    br.validates :bill_to_surname, presence: true
    br.validates :bill_to_email, presence: true
    br.validates :bill_to_address_line1, presence: true
    br.validates :bill_to_address_city, presence: true
    br.validates :bill_to_address_postal_code, presence: true
    br.validates :bill_to_address_state, presence: true
    br.validates :bill_to_address_country, presence: true
    br.validates :bill_to_phone, presence: true
    
    br.validates :ship_to_forename, presence: true
    br.validates :ship_to_surname, presence: true
    br.validates :ship_to_address_line1, presence: true
    br.validates :ship_to_address_city, presence: true
    br.validates :ship_to_address_postal_code, presence: true
    br.validates :ship_to_address_state, presence: true
    br.validates :ship_to_address_country, presence: true
    br.validates :ship_to_phone, presence: true
  end

  aasm :column => :decision do # default column: aasm_state
    state :pending, :initial => 'pending'
    state :accepted
    state :declined
    state :rejected
    state :other
  
    event :accept do
      transitions :from => :pending, :to => :accepted
    end
  
    event :decline do
      transitions :from => :pending, :to => :declined
    end
  
    event :reject do
      transitions :from => :pending, :to => :rejected, :after => :notify_competition_closed
    end
  
    event :other do
      transitions :from => :pending, :to => :other, :after => :notify_competition_closed
    end

  end


end
