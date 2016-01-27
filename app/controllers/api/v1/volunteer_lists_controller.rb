class Api::V1::VolunteerListsController < ActionController::Base
  protect_from_forgery with: :null_session

  def create
    volunteer_list = VolunteerList.new(vol_params)
    if volunteer_list.save
      render json: :nothing, status: :created, location: api_v1_volunteer_lists_path
    else
      render json: :nothing, status: :not_found
    end
  end

  private
  def vol_params
    params.require(:volunteer_list).permit(:user_id, :opportunity_id)
  end
end
