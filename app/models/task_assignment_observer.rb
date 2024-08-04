class TaskAssignmentObserver < ActiveRecord::Observer
    def after_create(task_assignment)
        task = task_assignment.task.id
        recipient = task_assignment.recipient.id
        TaskAssignmentMailer.with(user_id: recipient, task_id: task).assignment_email.deliver_later
    end
end
