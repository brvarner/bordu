ActionMailbox::Base.class_eval do
  before_processing do |inbound_email|
    Rails.logger.info "Processing inbound email: #{inbound_email.message_id}"
  end
end