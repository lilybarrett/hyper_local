class Cause < ActiveRecord::Base
  validates :cause, uniqueness: true
end
