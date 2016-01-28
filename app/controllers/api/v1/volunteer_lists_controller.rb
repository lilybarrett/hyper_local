class Api::V1::VolunteerListsController < ActionController::Base
  protect_from_forgery with: :null_session

  def create
    volunteer_list = VolunteerList.new(vol_params)
    if volunteer_list.save
      render json: {
        user_id: current_user.id,
        opportunity_id: volunteer_list.opportunity.id,
        image_source: profile_photo_handler,
        user_first_name: current_user.first_name,
        user_last_initial: current_user.last_name.first
      }
    else
      render json: { errors: volunteer_list.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private
  def vol_params
    params.require(:volunteer_list).permit(:user_id, :opportunity_id)
  end

  def profile_photo_handler
    if current_user.profile_photo_url
      current_user.profile_photo_url
    else
      "http://www.carderator.com/assets/avatar_placeholder_small.png"
    end
  end
end
