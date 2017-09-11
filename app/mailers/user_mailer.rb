class UserMailer < ApplicationMailer
  
  def transaction_email(admin_id, invoice_id)
    @user             = User.find_by_id(admin_id)
    @invoice          = Invoice.find_by_id(invoice_id)
    
    mail(:to => @user.email, :cc=> @invoice.bill_to_email, :subject => 'Transaction Response', :from => 'info@appsgenii.com')
  end
end
