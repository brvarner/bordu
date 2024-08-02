class ActionMailbox::Ingresses::Mailgun::InboundEmailsController < ActionMailbox::Ingresses::Mailgun::InboundEmailsController
  def create
    Rails.logger.info "Received Mailgun webhook: #{request.body.read}"
    super
  rescue StandardError => e
    Rails.logger.error "Error processing Mailgun webhook: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    head :internal_server_error
  end
end
