class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Pundit::AuthorizationNotPerformedError, with: :authorization_not_performed

  after_action :verify_authorized, unless: :devise_controller?
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'

    redirect_to(request.referrer || root_path)
  end

  def authorization_not_performed
    flash[:alert] = 'An authorization error occurred.'
    redirect_to(request.referrer || root_path)
    nil
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
