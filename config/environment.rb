# Load the Rails application.
require_relative 'application'

ENV['API_KEY'] = 'jDpKdDSRYBtPsaRttaYwGHjd34KtOgxx'
# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name: 'apikey',
  password: ENV['SENDGRID_API_KEY'],
  domain: 'localhost:3000',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}.freeze
