# Eventually, we'll implement a token system to ensure that only those assigned can reply to the email that writes to the database.

class UpdatesMailbox < ApplicationMailbox
  def process
    Rails.logger.info 'Email Received'

    reply_user = extract_user_id_from_email
    Rails.logger.info "Extracting User ID: #{reply_user}"
    return if reply_user.blank?

    user = User.find_by(id: reply_user)
    Rails.logger.info "Finding user: #{user.inspect}"
    return if user.nil?

    if TaskUpdate.exists?(message_id: mail.message_id)
      Rails.logger.info 'Task update already exists for this message_id.'
      return
    end

    safe_body = sanitize_and_trim_email_body(mail_body)
    Rails.logger.info 'Sanitizing email...'
    return if safe_body.blank?

    task = Task.find_by(id: extract_task_id_from_email)
    Rails.logger.info "Finding task: #{task.inspect}"
    return if task.nil?

    task_update = TaskUpdate.new(
      task:,
      author_id: user.id,
      body: safe_body,
      message_id: mail.message_id
    )

    Rails.logger.info 'Receiving update...'
    if task_update.save
      Rails.logger.info 'Task update saved successfully.'
    else
      Rails.logger.error "Failed to save task update: #{task_update.errors.full_messages.join(', ')}"
    end
  end

  private

  def extract_user_id_from_email
    mail.to.first.split('@').first.split('.').second.to_i
  end

  def extract_task_id_from_email
    mail.to.first.split('@').first.split('.').third.to_i
  end

  def sanitize_and_trim_email_body(body)
    trimmed_body = trim_email_body(body)
    return if trimmed_body.blank?

    Rails::Html::WhiteListSanitizer.new.sanitize(body)
  end

  def trim_email_body(email_body)
    trimmed_body = email_body.split(/On\s.+\swrote:/).first ||
                   email_body.split(/From:.+Sent:/).first ||
                   email_body.split(/Forwarded message:/).first

    Rails.logger.info 'Email body is empty after trimming.' if trimmed_body.blank?

    trimmed_body.strip
  end

  def mail_body
    if mail.multipart?
      mail.parts.each do |part|
        if part.content_type.start_with?('text/plain')
          return plain_text_body = part.decoded
        elsif part.content_type.start_with?('text/html')
          return html_body = part.decoded
        end
      end
    else
      email_body = mail.decoded
    end
  end
end
