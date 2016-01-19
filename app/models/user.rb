class User < ActiveRecord::Base
  has_many :org_admins
  has_many :organizations, through: :org_admins

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true

  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable
end
