class UsersController < ApplicationController
  def show
    @user = current_user
    @organizations = @user.organizations
    @opportunities = @user.opportunities.upcoming.order(date: :asc)
  end
end
