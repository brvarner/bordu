Mailgun.configure do |config|
  config.api_key = Rails.application.credentials.dig(:action_mailer, :api_key)
end
