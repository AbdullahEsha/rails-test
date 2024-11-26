class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Configure additional parameters for Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role_id])
  end

  # Set the locale for each request
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
