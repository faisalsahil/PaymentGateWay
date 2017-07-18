class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.string :consumer_id
      t.decimal :amount, :null => false
      t.string :currency, :null => false
      t.string :reference_number, :null => false
      t.string :customer_ip_address

      t.string :bill_to_forename
      t.string :bill_to_surname
      t.string :bill_to_email
      t.string :bill_to_address_line1
      t.string :bill_to_address_city
      t.string :bill_to_address_postal_code
      t.string :bill_to_address_state
      t.string :bill_to_address_country
      t.string :bill_to_phone

      t.string :ship_to_forename
      t.string :ship_to_surname
      t.string :ship_to_address_line1
      t.string :ship_to_address_city
      t.string :ship_to_address_postal_code
      t.string :ship_to_address_state
      t.string :ship_to_address_country
      t.string :ship_to_phone
      
      t.string :req_card_expiry_date
      t.string :reason_code
      t.string :req_device_fingerprint_id
      t.string :decision
      t.string :message
      t.string :transaction_id
      t.string :payer_authentication_xid
      
      t.string :transaction_type, :null => false
      t.string :transaction_uuid, :null => false
      t.string :security_token, :null => false
      t.string :auth_token, :null => false
      
      t.string :signed_date_time

      t.string :invoice_status, default: 'pending'
      
      t.timestamps
    end
  end
end

