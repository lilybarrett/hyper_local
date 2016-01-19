class CreateCauses < ActiveRecord::Migration
  def change
    create_table :causes do |t|
      t.string :cause, null: false
    end

    add_index :causes, :cause, unique: true
  end
end
