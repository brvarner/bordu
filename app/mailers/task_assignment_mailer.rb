class TaskAssignmentMailer < ApplicationMailer
  default from: "Bordu <info@bordu.vip>"

  def assignment_email
    @recipient = User.find(params[:user_id])
    @task = Task.find(params[:task_id])
    @token = generate_token(@recipient.id, @task.id)
    mail(to: @recipient.email, subject: "Task ##{@task.id} - #{@task.title} Assigned To You", reply_to: "'Bordu' <updates.#{@recipient.id}.#{@task_id}@parse.bordu.vip>")
  end

  private

  def generate_token(recipient_id, task_id)
    Digest::SHA256.hexdigest("#{recipient_id}-#{task_id}-#{SecureRandom.hex(10)}")
  end

end
