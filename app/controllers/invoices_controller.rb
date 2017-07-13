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
    @invoice.auth_token = SecureRandom.uuid
    @invoice.security_token = SecureRandom.hex(16)
    @invoice.transaction_uuid = SecureRandom.uuid
    @invoice.transaction_type = 'authorization'
    
    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
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
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "appsgenii" && password == "payments"
    end
  end
  
  private
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit(:amount, :currency, :reference_number, :customer_firstname, :customer_lastname, :customer_email, :bill_address1, :bill_city, :bill_country, :client_phone)
    end


end
