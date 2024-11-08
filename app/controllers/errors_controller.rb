# app/controllers/errors_controller.rb
class ErrorsController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped
  def not_found
    respond_to do |format|
      format.html { render 'errors/not_found', status: :not_found }
      format.all { render nothing: true, status: :not_found }
    end
  end

  def internal_server_error
    respond_to do |format|
      format.html { render 'errors/internal_server_error', status: :internal_server_error }
      format.all { render nothing: true, status: :internal_server_error }
    end
  end
end
