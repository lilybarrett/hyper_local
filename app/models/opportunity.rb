class Opportunity < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_city,
    against: [:city]
  pg_search_scope :search_by_cause,
    associated_against: {
    cause: [:cause]
  }

  belongs_to :organization
  has_one :cause, through: :organization
  has_many :volunteer_lists
  has_many :users, through: :volunteer_lists

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

  scope :upcoming, -> { where("opportunities.date >= ?", Date.today) }
end
