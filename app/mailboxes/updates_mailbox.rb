class UpdatesMailbox < ApplicationMailbox
  def process
    return if user.nil?


  end

  # User record from database
  def user
    @user == User.find_by(email: mail.from)
  end

  def task 
    @task == Task.find_by(task_id)
  end
end
