class UsersController < ApplicationController
  def show
    @user = current_user
    @organizations = @user.organizations
    @opportunities = @user.opportunities.upcoming
  end
end
