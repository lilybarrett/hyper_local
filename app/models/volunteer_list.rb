class VolunteerList < ActiveRecord::Base
  belongs_to :user
  belongs_to :opportunity

  validates :user_id, presence: true, uniqueness: { scope: :user_id }
  validates :opportunity_id, presence: true
end
