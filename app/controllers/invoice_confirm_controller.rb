class InvoiceConfirmController < ApplicationController
  # layout false
  
  def edit
    @invoice = Invoice.find_by_auth_token_and_security_token(params[:auth_token],params[:security_token])
    if @invoice.present?
    else
      render plain: "Invoice not found"
    end
  end
  
  
  def confirm
    @invoice = Invoice.find_by_auth_token_and_security_token(params[:auth_token],params[:security_token])
    
    if @invoice.present? #&& @invoice.invoice_status == 'pending'
      @invoice.attributes          = invoice_confirm_params
      @invoice.is_confirm_invoice  = true
      @invoice.signed_date_time    = signed_date_time
      @invoice.invoice_status      = 'processing'
      @invoice.customer_ip_address = request.remote_ip
      
      respond_to do |format|
        if @invoice.save
          format.html { redirect_to invoice_confirm_verify_path({ auth_token: params[:auth_token],security_token: params[:security_token] }) }
        else
          format.html { render :edit }
        end
      end
    else
      render plain: "Invoice not found"
    end
  end
  
  
  def verify
    @invoice              = Invoice.find_by_auth_token_and_security_token(params[:auth_token],params[:security_token])

    @signed_field_names   = 'consumer_id,customer_ip_address,access_key,profile_id,transaction_uuid,signed_field_names,unsigned_field_names,signed_date_time,locale,transaction_type,reference_number,amount,currency,bill_to_forename,bill_to_surname,bill_to_email,bill_to_address_line1,bill_to_address_city,bill_to_address_postal_code,bill_to_address_state,bill_to_address_country,bill_to_phone,ship_to_forename,ship_to_surname,ship_to_address_line1,ship_to_address_city,ship_to_address_postal_code,ship_to_address_state,ship_to_address_country,ship_to_phone'
    @unsigned_field_names = ''
    
    params[:consumer_id]      = @invoice.consumer_id
    params[:reference_number] = @invoice.reference_number
    params[:amount]           = @invoice.amount
    params[:currency]         = @invoice.currency
    
    params[:bill_to_forename]            = @invoice.bill_to_forename
    params[:bill_to_surname]             = @invoice.bill_to_surname
    params[:bill_to_email]               = @invoice.bill_to_email
    params[:bill_to_address_line1]       = @invoice.bill_to_address_line1
    params[:bill_to_address_city]        = @invoice.bill_to_address_city
    params[:ship_to_address_postal_code] = @invoice.ship_to_address_postal_code
    params[:ship_to_address_state]       = @invoice.ship_to_address_state
    params[:bill_to_address_country]     = @invoice.bill_to_address_country
    params[:bill_to_phone]               = @invoice.bill_to_phone

    params[:ship_to_forename]            = @invoice.ship_to_forename
    params[:ship_to_surname]             = @invoice.ship_to_surname
    params[:ship_to_address_line1]       = @invoice.ship_to_address_line1
    params[:ship_to_address_city]        = @invoice.ship_to_address_city
    params[:ship_to_address_postal_code] = @invoice.ship_to_address_postal_code
    params[:ship_to_address_state]       = @invoice.ship_to_address_state
    params[:ship_to_address_country]     = @invoice.ship_to_address_country
    params[:ship_to_phone]               = @invoice.ship_to_phone


    params[:customer_ip_address]   = @invoice.customer_ip_address
    params[:merchant_define_data1] = 'WC'
    
    params[:access_key]           = ENV['HBL_ACCESS_KEY_' + ENV['HBL_MODE']]
    params[:profile_id]           = ENV['HBL_PROFILE_KEY_' + ENV['HBL_MODE']]
    params[:transaction_uuid]     = @invoice.transaction_uuid
    params[:signed_field_names]   = @signed_field_names
    params[:unsigned_field_names] = @unsigned_field_names
    params[:signed_date_time]     = @invoice.signed_date_time
    params[:locale]               = 'en'
    params[:transaction_type]     = @invoice.transaction_type
    
    @signature = Security.generate_signature(params)
  
  end
  
  def success
    @invoice = Invoice.find_by_transaction_uuid(params[:req_transaction_uuid])
    if @invoice.present?
      @invoice.req_card_expiry_date      = params[:req_card_expiry_date]
      @invoice.reason_code               = params[:reason_code]
      @invoice.req_device_fingerprint_id = params[:req_device_fingerprint_id]
      @invoice.decision                  = params[:decision]
      @invoice.message                   = params[:message]
      @invoice.transaction_id            = params[:transaction_id]
      @invoice.payer_authentication_xid  = params[:payer_authentication_xid]
      @invoice.save
    end
  end
  
  def failure
  
  end
  
  private
  
  def invoice_confirm_params
    params.require(:invoice).permit(
        :bill_to_forename,:bill_to_surname,:bill_to_email,:bill_to_address_line1,:bill_to_address_city,:bill_to_address_postal_code,:bill_to_address_state,:bill_to_address_country,:bill_to_phone,
        :ship_to_forename,:ship_to_surname,:ship_to_address_line1,:ship_to_address_city,:ship_to_address_postal_code,:ship_to_address_state,:ship_to_address_country,:ship_to_phone
    )
  end
  
  def signed_date_time
    current_utc_xml_date_time = Time.now.utc.strftime "%Y-%m-%dT%H:%M:%S%z"
    current_utc_xml_date_time = current_utc_xml_date_time[0,current_utc_xml_date_time.length-5]
    current_utc_xml_date_time << 'Z'
    current_utc_xml_date_time
  end

end
