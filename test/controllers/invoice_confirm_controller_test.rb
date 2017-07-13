require 'test_helper'

class InvoiceConfirmControllerTest < ActionDispatch::IntegrationTest
  test "should get confirm" do
    get invoice_confirm_confirm_url
    assert_response :success
  end

end
