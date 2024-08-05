class HomeController < ApplicationController
  before_action :skip_authorization, only: :index
  def index
    render
  end
end