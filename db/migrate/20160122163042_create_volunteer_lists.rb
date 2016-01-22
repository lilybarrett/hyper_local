class CreateVolunteerLists < ActiveRecord::Migration
  def change
    create_join_table :users, :opportunities, table_name: :volunteer_lists
  end
end
