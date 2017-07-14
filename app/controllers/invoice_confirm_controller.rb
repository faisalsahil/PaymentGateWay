class InvoiceConfirmController < ApplicationController
  
  def edit
    @invoice = Invoice.find_by_auth_token_and_security_token(params[:auth_token], params[:security_token])
    if @invoice.present?
    else
      render plain: "Invoice not found"
    end
  end
  
  
  def confirm
    @invoice = Invoice.find_by_auth_token_and_security_token(params[:auth_token], params[:security_token])
    
    if @invoice.present? #&& @invoice.invoice_status == 'pending'
      
      @invoice.attributes         = invoice_confirm_params
      @invoice.is_confirm_invoice = true
      @invoice.signed_date_time   = signed_date_time
      @invoice.invoice_status     = 'processing'
      
      respond_to do |format|
        if @invoice.save
          format.html { redirect_to invoice_confirm_verify_path({ auth_token: params[:auth_token], security_token: params[:security_token] }) }
        else
          format.html { render :edit }
        end
      end
    else
      render plain: "Invoice not found"
    end
  end
  
  
  def verify
    @invoice     = Invoice.find_by_auth_token_and_security_token(params[:auth_token], params[:security_token])

    # ,bill_to_address_line1,bill_to_address_city,bill_to_address_country,bill_to_email,bill_to_surname,bill_to_forename
    @signed_field_names = 'access_key,profile_id,transaction_uuid,signed_field_names,unsigned_field_names,signed_date_time,locale,transaction_type,reference_number,amount,currency,bill_to_address_line1,bill_to_address_city,bill_to_address_country,bill_to_email,bill_to_surname,bill_to_forename'
    @unsigned_field_names = ''
    
    params[:bill_to_address_line1]   = @invoice.bill_address1
    params[:bill_to_address_city]    = @invoice.bill_city
    params[:bill_to_address_country] = @invoice.bill_country
    params[:bill_to_email]           = @invoice.customer_email
    params[:bill_to_surname]         = @invoice.customer_firstname
    params[:bill_to_forename] = @invoice.customer_lastname
    
    params[:access_key] = ENV['HBL_ACCESS_KEY_' + ENV['HBL_MODE']]
    params[:profile_id] = ENV['HBL_PROFILE_KEY_' + ENV['HBL_MODE']]
    params[:transaction_uuid] = @invoice.transaction_uuid
    params[:signed_field_names] = @signed_field_names
    params[:unsigned_field_names] = @unsigned_field_names
    params[:signed_date_time] = @invoice.signed_date_time
    params[:locale] = 'en'
    params[:transaction_type] = @invoice.transaction_type
    params[:reference_number] = @invoice.reference_number
    params[:amount] = @invoice.amount
    params[:currency] = @invoice.currency
    
    @signature = Security.generate_signature(params)
  
  end
  
  def success
  end
  
  def failure
    
  end
  
  private
  def invoice_confirm_params
    params.require(:invoice).permit(:customer_firstname, :customer_lastname, :customer_email, :bill_address1, :bill_city, :bill_country, :client_phone)
  end
  
  def signed_date_time
    current_utc_xml_date_time = Time.now.utc.strftime "%Y-%m-%dT%H:%M:%S%z"
    current_utc_xml_date_time = current_utc_xml_date_time[0, current_utc_xml_date_time.length-5]
    current_utc_xml_date_time << 'Z'
    current_utc_xml_date_time
  end
  
end
