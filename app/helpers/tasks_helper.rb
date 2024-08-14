module TasksHelper
  def setup_task_form(project)
    project ||= Project.new
    task = Task.new(project:)
    [project, task]
  end
end
