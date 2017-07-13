class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.string :customer_firstname
      t.string :customer_lastname
      t.string :customer_email
      t.string :bill_address1
      t.string :bill_city
      t.string :bill_country
      t.string :client_phone
      t.decimal :amount, :null => false
      t.string :currency, :null => false
      t.string :reference_number, :null => false
      t.string :transaction_type, :null => false
      t.string :transaction_uuid, :null => false
      t.string :security_token, :null => false
      t.string :auth_token, :null => false
      t.string :invoice_status, default: 'pending'
      t.string :signed_date_time
      
      t.timestamps
    end
  end
end
