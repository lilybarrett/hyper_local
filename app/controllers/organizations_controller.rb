class OrganizationsController < ApplicationController
  def new
    # if @user.volunteer?
      @organization = Organization.new
      @causes = []
      Cause.all.each do |cause|
        @causes << [cause.cause, cause.id]
      end
    # else
    #   flash[:message] = "You must be representing an organization in order to view this page."
    # end
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

  def edit
    @organization = Organization.find(params[:id])
    @causes = []
    Cause.all.each do |cause|
      @causes << [cause.cause, cause.id]
    end
    if Organization.org_admins(current_user, @organization)
      render :edit
    else
      flash[:message] = "You are not authorized to view this page."
      render :show
    end
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update_attributes(organization_params)
      flash[:notice] = "Organization successfully updated"
      redirect_to organization_path(@organization)
    else
      flash[:error] = "Please fill out all required fields."
      render :edit
    end
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
