class ApplicationController < ActionController::Base
  # debugger
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

	before_filter do
	  resource = controller_name.singularize.to_sym
	  method = "#{resource}_params"
	  params[resource] &&= send(method) if respond_to?(method, true)
	end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :roll, :email, :password, :password_confirmation)}
    # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :avatar) }
  end
end
