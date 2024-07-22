class TaskAssignmentObserver < ActiveRecord::Observer
    def after_create(task_assignment)
        # Here, we trigger an action mailer with the user's email address and the task name/description.
        task = task_assignment.task.id
        recipient = task_assignment.recipient.id
        TaskAssignmentMailer.with(user_id: recipient, task_id: task).assignment_email.deliver_now
    end
end
