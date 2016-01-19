class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :street, null: false
      t.string :city, null: false
      t.string :state, null: false

      t.belongs_to :cause, null: false
    end
  end
end
