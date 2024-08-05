class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user:).or(scope.joins(:tasks).where(tasks: { assigned_to: user })).distinct
    end
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
    update?
  end

  private

  def user_is_owner?
    user == record.user
  end

  def user_is_owner_or_assigned?
    user_is_owner? || record.tasks.joins(:assignments).exists?(task_assignments: { user_id: user })
  end
end
