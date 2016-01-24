class VolunteerListsController < ApplicationController

  def create
    @opportunity = Opportunity.find(params[:opportunity_id])
    @volunteer_list = VolunteerList.new
    @volunteer_list.user = current_user
    @volunteer_list.opportunity = @opportunity
     if @volunteer_list.save
       flash[:notice] = "Thanks for volunteering with us! Let's make a difference together!"
       redirect_to opportunity_path(@opportunity)
     else
       flash[:errors] = @volunteer_list.errors.full_messages.join(". ")
       redirect_to opportunity_path(@opportunity)
     end
  end

end
