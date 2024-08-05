class ApplicationController < ActionController::Base
  include Pundit

  after_action :verify_authorized, unless: :devise_controller?
  # after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'

    redirect_to(request.referrer || root_path)
  end
end
