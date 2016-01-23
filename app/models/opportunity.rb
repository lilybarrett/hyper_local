class Opportunity < ActiveRecord::Base
  belongs_to :organization
  has_many :volunteer_lists
  has_many :users, through: :volunteer_lists
  has_many :users, through: :org_admins

  validates :description, presence: true
  validates :capacity, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1
  }
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :organization_id, presence: true

  scope :upcoming, -> { where("opportunities.date >= ?", Date.today)}
end
