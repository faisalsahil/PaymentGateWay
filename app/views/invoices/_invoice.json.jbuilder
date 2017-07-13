json.extract! invoice, :id, :customer_firstname, :customer_lastname, :customer_email, :bill_address1, :bill_city, :bill_country, :client_phone, :amount, :currency, :reference_number, :transaction_type, :transaction_uuid, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
