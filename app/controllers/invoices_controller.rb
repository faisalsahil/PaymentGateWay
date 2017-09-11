class InvoicesController < ApplicationController
  before_filter :authenticate
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  
  def index
    @invoices = Invoice.all
  end
  
  def show
  end
  
  def new
    @invoice = Invoice.new
  end
  
  def edit
  end
  
  def create
    @invoice = Invoice.new(invoice_params)
    
    @invoice.auth_token       = SecureRandom.uuid
    @invoice.security_token   = SecureRandom.hex(16)
    @invoice.transaction_uuid = SecureRandom.uuid
    @invoice.transaction_type = 'authorization'
    
    
    respond_to do |format|
      if @invoice.save
        format.html { redirect_to invoices_path, notice: 'Invoice was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end
  
  def reset
    @invoice = Invoice.find_by_id(params[:id])
    
    @invoice.auth_token       = SecureRandom.uuid
    @invoice.security_token   = SecureRandom.hex(16)
    @invoice.transaction_uuid = SecureRandom.uuid
    @invoice.transaction_type = 'authorization'
    @invoice.invoice_status   = 'pending'
    @invoice.decision         = 'pending'
    
    respond_to do |format|
      if @invoice.save
        format.html { redirect_to invoices_path, notice: 'Invoice was successfully reset' }
      else
        format.html { render :new }
      end
    end
  end
  
  
  def copy
    @old_invoice              = Invoice.find_by_id(params[:id])
    @invoice                  = @old_invoice.dup
    
    # @invoice.parent_id        = @old_invoice.id
    @invoice.auth_token       = SecureRandom.uuid
    @invoice.security_token   = SecureRandom.hex(16)
    @invoice.transaction_uuid = SecureRandom.uuid
    @invoice.transaction_type = 'authorization'
    
    @invoice.signed_date_time    = nil
    @invoice.invoice_status      = 'pending'
    @invoice.customer_ip_address = nil
    
    @invoice.req_card_expiry_date      = nil
    @invoice.reason_code               = nil
    @invoice.req_device_fingerprint_id = nil
    @invoice.decision                  = nil
    @invoice.message                   = nil
    @invoice.transaction_id            = nil
    @invoice.payer_authentication_xid  = nil
    
    respond_to do |format|
      if @invoice.save
        format.html { redirect_to invoices_path, notice: 'Invoice was successfully copied.' }
      else
        format.html { render :new }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    # @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # def failure
  #   UserMailer.transaction_email(1, Invoice.last.id).deliver_later
  # end
  
  protected
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['HBL_AUTH_USERNAME_' + ENV['HBL_MODE']] && password == ENV['HBL_AUTH_PASSWORD_' + ENV['HBL_MODE']]
    end
  end
  
  private
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end
  
  def invoice_params
    params.require(:invoice).permit(
        :consumer_id, :amount, :currency, :reference_number,
        :bill_to_forename, :bill_to_surname, :bill_to_email, :bill_to_address_line1, :bill_to_address_city, :bill_to_address_postal_code, :bill_to_address_state, :bill_to_address_country, :bill_to_phone,
        :ship_to_forename, :ship_to_surname, :ship_to_address_line1, :ship_to_address_city, :ship_to_address_postal_code, :ship_to_address_state, :ship_to_address_country, :ship_to_phone
    )
  end


end