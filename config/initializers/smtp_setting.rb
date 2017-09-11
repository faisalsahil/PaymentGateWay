ActionMailer::Base.smtp_settings = {
    address:   ENV['HBL_SMTP_ADDRESS_' + ENV['HBL_MODE']],
    domain:    ENV['HBL_SMTP_DOMAIN_' + ENV['HBL_MODE']],
    user_name: ENV['HBL_SMTP_USERNAME_' + ENV['HBL_MODE']],
    password:  ENV['HBL_SMTP_PASSWORD_' + ENV['HBL_MODE']],
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
}