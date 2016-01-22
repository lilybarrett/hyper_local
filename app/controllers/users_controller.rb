class UsersController < ApplicationController
  def show
    @user = current_user
    @organizations = @user.organizations
  end
end
