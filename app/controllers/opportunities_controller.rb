class OpportunitiesController < ApplicationController
  def index
    @opportunities = Opportunity.all
  end

  def new
    @organization = Organization.find(params[:organization_id])
    @opportunity = Opportunity.new
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @opportunity = @organization.opportunities.new(opportunity_params)
      if @opportunity.save
        redirect_to organization_opportunity_path(@organization, @opportunity)
      else
        flash[:error] = @opportunity.errors.full_messages.join('. ')
        render :new
      end
  end

  def show
    @organization = Organization.find(params[:organization_id])
    @opportunities = @organization.opportunities
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
