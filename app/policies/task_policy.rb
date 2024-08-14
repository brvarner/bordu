class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(project: user.projects).or(scope.joins(:assignments).where(task_assignments: { user_id: user }))
    end
  end

  def index?
    false
  end

  def show?
    user_is_owner_or_assigned?
  end

  def create?
    return false unless user.present?

    if record.is_a?(Task)
      # For an existing task
      project = record.project
    elsif record == Task
      # For a new task (class check)
      project_id = params[:project_id]
      project = Project.find_by(id: project_id)
    else
      return false
    end

    project&.creator == user
  end

  def update?
    user_is_owner_or_assigned?
  end

  def destroy?
    user_is_owner?
  end

  private

  def user_is_owner?
    user == record.creator
  end

  def user_is_owner_or_assigned?
    user_is_owner? || record.assignments.exists?(user_id: user.id)
  end
end
