class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|
      t.string :description, null: false
      t.integer :capacity, null: false
      t.string :street, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.date :date, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false

      t.belongs_to :organization, null: false
      t.timestamps null: false
    end
  end
end
