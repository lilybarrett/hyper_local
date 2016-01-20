class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(_resource)
    if @user.volunteer?
      root_path
    else
      new_organization_path
    end
  end
end
