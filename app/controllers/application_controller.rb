class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) <<
      [:first_name, :last_name, :volunteer, :profile_photo]
    devise_parameter_sanitizer.for(:account_update) <<
      [:volunteer, :profile_photo]
  end
end
