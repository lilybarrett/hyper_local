class Organization < ActiveRecord::Base
  has_many :org_admins
  has_many :users, through: :org_admins
  has_many :opportunities 
  belongs_to :cause

  validates :name, presence: true
  validates :description, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true

  validates :cause_id, presence: true

  def self.org_admins(user, organization)
    if !OrgAdmin.where(user: user, organization: organization).empty?
      return true
    end
  end
end
