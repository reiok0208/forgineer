class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  PER = 10

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :nickname, :introduction, :profile_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :nickname, :introduction, :profile_image])
  end
end
