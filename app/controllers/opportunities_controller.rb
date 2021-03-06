class OpportunitiesController < ApplicationController
  def index
    @opportunities = Opportunity.upcoming.order(date: :asc) 
  end

  def new
    @organization = Organization.find(params[:organization_id])
    @opportunity = Opportunity.new
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @opportunity = @organization.opportunities.new(opportunity_params)
    if @opportunity.save
      redirect_to organization_path(@organization)
    else
      flash[:error] = @opportunity.errors.full_messages.join('. ')
      render :new
    end
  end

  def show
    @opportunity = Opportunity.find(params[:id])
    @organization = @opportunity.organization
    @volunteers = @opportunity.users
    @volunteer_list = VolunteerList.find_by(user: current_user, opportunity: @opportunity)
  end

  def edit
    @opportunity = Opportunity.find(params[:id])
  end

  def update
    @opportunity = Opportunity.find(params[:id])
    @organization = @opportunity.organization
    if @opportunity.update_attributes(opportunity_params)
      flash[:notice] = "Opportunity successfully updated"
      redirect_to organization_path(@organization)
    else
      flash[:error] = "Please fill out all required fields."
      render :edit
    end
  end

  def destroy
    @organization = Organization.find(params[:organization_id])
    Opportunity.find(params[:id]).destroy

    redirect_to organization_path(@organization)
  end

  private

  def opportunity_params
    params.require(:opportunity).permit(
      :description,
      :capacity,
      :street,
      :city,
      :state,
      :date,
      :start_time,
      :end_time,
      :organization_id
    )
  end
end
