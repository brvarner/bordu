class TaskAssignmentObserver < ActiveRecord::Observer
    def after_create(task_assignment)
        # Here, we trigger an action mailer with the user's email address and the task name/description.
        task_creator = task_assignment.task.creator
        project = task_assignment.task.project
        title = task_assignment.task.title
        desc = task_assignment.task.description
        recipient = task_assignment.recipient
    end
end
