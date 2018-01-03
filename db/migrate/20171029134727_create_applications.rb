class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications do |t|
      t.string :d_from
      t.string :d_to
      t.string :plan
      t.integer :num_of_beds
      t.integer :receptionist_ssn
      t.integer :Manager_ssn
      t.integer :Client_id
      t.integer :reserv_id

      t.timestamps
    end
  end
end
