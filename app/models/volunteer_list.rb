class VolunteerList < ActiveRecord::Base
  belongs_to :user
  belongs_to :opportunity

  validates :user_id, presence: true
  validates :opportunity_id, presence: true
end
