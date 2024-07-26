class TaskAssignmentMailer < ApplicationMailer
  default from: "Bordu <info@bordu.vip>"

  def assignment_email
    @recipient = User.find(params[:user_id])
    @task = Task.find(params[:task_id])
    mail(to: @recipient.email, subject: "Task ##{@task.id} - #{@task.title} Assigned To You", reply_to: "'Bordu' <updates.#{@recipient.id}.#{@task.id}@parse.bordu.vip>")
  end

end
