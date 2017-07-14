class AddFieldsToInvoices < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :req_card_expiry_date, :string
    add_column :invoices, :reason_code, :string
    add_column :invoices, :req_device_fingerprint_id, :string
    add_column :invoices, :decision, :string
    add_column :invoices, :message, :string
    add_column :invoices, :transaction_id, :string
    add_column :invoices, :payer_authentication_xid, :string
  end
end
