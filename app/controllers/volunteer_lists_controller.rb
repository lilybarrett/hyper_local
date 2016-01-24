class VolunteerListsController < ApplicationController
  def create
    @opportunity = Opportunity.find(params[:opportunity_id])
    @volunteer_list = VolunteerList.new
    @volunteer_list.user = current_user
    @volunteer_list.opportunity = @opportunity
      if @volunteer_list.save
         flash[:notice] =
           "Thanks for volunteering with us! Let's make a difference together!"
         redirect_to opportunity_path(@opportunity)
       else
         flash[:notice] = "You're already signed up for this activity!"
         redirect_to opportunity_path(@opportunity)
       end
  end
end
