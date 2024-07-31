# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Rails.application.configure do
  config.action_mailbox.ingress = :sendgrid
  config.action_mailbox.ingress_password = Rails.application.credentials.dig(:action_mailbox, :ingress_password)
end
