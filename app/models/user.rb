class User < ActiveRecord::Base
  has_many :org_admins
  has_many :organizations, through: :org_admins
  has_many :volunteer_lists
  has_many :opportunities, through: :volunteer_lists

  validates :first_name, presence: true
  validates :last_name, presence: true

  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable
end
