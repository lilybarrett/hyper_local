class ChangeVolunteerLists < ActiveRecord::Migration
  def change
    add_column :volunteer_lists, :id, :primary_key
  end
end
