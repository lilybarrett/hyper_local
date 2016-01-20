class OrganizationsController < ApplicationController
  def new
    @organization = Organization.new
    @causes = []
    Cause.all.each do |cause|
      @causes << [cause.cause, cause.id]
    end
  end

  def create
    @organization = Organization.new(organization_params)
    @user = current_user
    @admin_list = OrgAdmin.new
    @admin_list.user = current_user
    if @organization.save
      @admin_list.organization = @organization
      @admin_list.save
      flash[:notice] = "Organization successfully added!"
      redirect_to organization_path(@organization)
    else
      flash[:error] = @organization.errors.full_messages.join('. ')
      render :new
    end
  end

  def show
    @organization = Organization.find(params[:id])
  end

  private

  def organization_params
    params.require(:organization).permit(
      :name,
      :description,
      :street,
      :city,
      :state,
      :cause_id
    )
  end
end
