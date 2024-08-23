class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      projects_created_by_user = scope.where(creator_id: user.id)
      projects_with_assigned_tasks = scope.joins(tasks: :assignments)
                                          .where(task_assignments: { user_id: user.id })
      
      Project.where(id: projects_created_by_user.select(:id))
             .or(Project.where(id: projects_with_assigned_tasks.select(:id)))
             .distinct
    end
  end

  def index?
    true
  end

  def show?
    user_is_owner_or_assigned?
  end

  def create?
    user.present?
  end

  def update?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

  private

  def user_is_owner?
    user.id == record.creator_id
  end

  def user_is_owner_or_assigned?
    user_is_owner? || record.task_assignments.exists?(user_id: user.id)
  end
end