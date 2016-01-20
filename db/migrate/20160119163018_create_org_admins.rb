class CreateOrgAdmins < ActiveRecord::Migration
  def change
    create_join_table :users, :organizations, table_name: :org_admins
  end
end
