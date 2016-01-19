class OrganizationsController < ApplicationController

  def index
    @organizations = Organization.all.order("name ASC")
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.user = current_user
    if @organization.save
      flash[:notice] = "Organization successfully added!"
      redirect_to organization_path(@organization)
    else
      flash[:error] = @organization.errors.full_messages.join('. ')
      render :new
    end
  end

  # def show
  # end
  #
  # def edit
  # end
  #
  # def update
  # end
  #
  # def destroy
  # end

  private

  def organization_params
    params.require(:organization).permit(
      :name,
      :description,
      :street,
      :city,
      :state,
      :cause
    )

  end
end
