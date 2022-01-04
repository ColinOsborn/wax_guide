# Load the Rails application.
require_relative 'application'

ENV['API_KEY'] = 'jDpKdDSRYBtPsaRttaYwGHjd34KtOgxx'
ENV['SENDGRID_API_KEY'] = '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'
# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => 'apikey',
  :password => ENV['SENDGRID_API_KEY'],
  :domain => 'localhost:3000',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}