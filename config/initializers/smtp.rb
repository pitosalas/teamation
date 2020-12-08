ActionMailer::Base.smtp_settings = {
  address: 'smtp.sendgrid.net',
  port: 587,
  domain: 'brandeis-teamation.herokuapp.com',
  user_name: ENV['SENDGRID_USERNAME'],
  password: ENV['SENDGRID_PASSWORD'],
  authentication: :login,
  enable_starttls_auto: true
}

#if you are using the API key
ActionMailer::Base.smtp_settings = {
  domain: 'YOUR_DOMAIN.COM',
  address:        "smtp.sendgrid.net",
  port:            587,
  authentication: :plain,
  user_name:      'apikey',
  password:       ENV['SENDGRID_API_KEY']
}