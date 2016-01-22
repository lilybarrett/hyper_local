class Opportunity < ActiveRecord::Base
  belongs_to :organization
  has_many :volunteer_lists
  has_many :users, through: :volunteer_lists

  validates :description, presence: true
  validates :capacity, presence: true, numericality: {
    only_integer: true
  }
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :organization_id, presence: true
end
