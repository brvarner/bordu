class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Pundit::AuthorizationNotPerformedError, with: :authorization_not_performed

  after_action :verify_authorized, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?


  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'

    redirect_to(request.referrer || root_path)
  end

  def authorization_not_performed
    flash[:alert] = 'An authorization error occurred.'
    redirect_to(request.referrer || root_path)
    return
  end
end
