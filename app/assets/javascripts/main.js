$(document).ready(function () {
    $('.contact_same_as').change(function () {
        if (this.checked) {
            var forename = $('#invoice_bill_to_forename').val();
            var surame   = $('#invoice_bill_to_surname').val();
            var address_line1 = $('#invoice_bill_to_address_line1').val();
            var invoice_bill_to_address_city = $('#invoice_bill_to_address_city').val();
            var invoice_bill_to_address_postal_code = $('#invoice_bill_to_address_postal_code').val();
            var invoice_bill_to_address_state = $('#invoice_bill_to_address_state').val();
            var invoice_bill_to_address_country = $('#invoice_bill_to_address_country').val();
            var invoice_bill_to_phone = $('#invoice_bill_to_phone').val();

            $('#invoice_ship_to_forename').val(forename);
            $('#invoice_ship_to_surname').val(surame);
            $('#invoice_ship_to_address_line1').val(address_line1);
            $('#invoice_ship_to_address_city').val(invoice_bill_to_address_city);
            $('#invoice_ship_to_address_postal_code').val(invoice_bill_to_address_postal_code);
            $('#invoice_ship_to_address_state').val(invoice_bill_to_address_state);
            $('#invoice_ship_to_address_country').val(invoice_bill_to_address_country);
            $('#invoice_ship_to_phone').val(invoice_bill_to_phone);
        } else {
            alert(this.checked);
        }
    });
});