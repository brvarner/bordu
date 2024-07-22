class TaskAssignmentMailer < ApplicationMailer
  default from: "test@test.com"

  # We get user Id and task ID, so theoretically we should have access to all that info we're looking for
  def assignment_email
    @recipient = User.find(params[:user_id])
    @task = Task.find(params[:task_id])
    mail(to: @recipient.email, subject: "Task (#{@task.title}) Assigned To You")
  end

  # Theoretically, we can create an observer that looks for replies to the email after it's been sent?
end
