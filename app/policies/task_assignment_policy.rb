class TaskAssignmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end

  def create?
    user == record.task.project.user
  end

  def destroy?
    user == record.task.project.user || user == record.recipient
  end
end