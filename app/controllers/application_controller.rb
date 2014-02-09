class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :get_user
  before_action :authorize

  protected
  def authorize
    unless @logged_in_as
      redirect_to login_url notice: "Please sign in"
    end
  end

  def get_user
    user=Administrator.find_by(id: session[:user_id])
    @logged_in_as=user ? user.name : nil
  end
end
