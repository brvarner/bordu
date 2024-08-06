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
    user.present? && user.projects.exists?(id: record.project_id)
  end

  def update?
    user_is_owner_or_assigned?
  end

  def destroy?
    user_is_owner?
  end

  private

  def user_is_owner?
    user == record.project.user
  end

  def user_is_owner_or_assigned?
    user_is_owner? || record.assignments.exists?(user_id: user.id)
  end
end
