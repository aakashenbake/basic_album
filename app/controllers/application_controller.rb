class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
      if user_signed_in?
        flash[:alert] = "Not authorized to view this page"
        session[:user_return_to] = nil
        redirect_to root_url

      else              
        flash[:alert] = "You must first login to view this page"
        session[:user_return_to] = request.url
        redirect_to "/users/sign_in"
      end 
  end

	before_filter do
	  resource = controller_name.singularize.to_sym
	  method = "#{resource}_params"
	  params[resource] &&= send(method) if respond_to?(method, true)
	end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :roll, :email, :password, :password_confirmation)}
  end
end
