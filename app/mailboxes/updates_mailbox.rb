class UpdatesMailbox < ApplicationMailbox
  def process
    # Get a user id from reply-to or bail
    reply_user = extract_user_id_from_reply_to
    return if reply_user.blank?

    # Find a user by the id or bail
    user = User.find_by(id: reply_user)
    return if user.nil?

    return if TaskUpdate.exists?(message_id: inbound_email.message_id)

    safe_body = sanitize_email_body(mail_body)
    return if safe_body.blank?

    token = extract_token_from_body(safe_body)
    return unless valid_token?(token, user.id, extract_task_from_subject.id)

    task_update = TaskUpdate.new(
      task: extract_task_from_subject.id,
      author_id: user.id,
      body: safe_body,
      message_id: inbound_email.message_id
    )

    task_update.save!
  end

  private 

  def extract_user_id_from_reply_to
    mail.reply_to&.first&.split('<')&.last&.split('@')&.first&.split('.')&.last
  end

  def sanitize_email_body(body)
    Rails::Html::WhiteListSanitizer.new.sanitize(body)
  end

  def extract_task_from_subject
    task_id = mail.subject[/Task #(\d+)/, 1]
    Task.find_by(id: task_id)
  end

  def extract_token_from_body(body)
    body[/Token: (\h+)/, 1]
  end

  def valid_token?(token, user_id, task_id)
    expected_token = generate_token(user_id, task_id)
    ActiveSupport::SecurityUtils.secure_compare(token, expected_token)
  end

  def generate_token
    key = SecureRandom.hex(10)
    Digest::SHA256.hexdigest("#{user_id}-#{task_id}-#{key}")
  end

  def mail_body
    mail.decoded
  end
end
