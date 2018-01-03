class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.string :Status
      t.integer :Manager_ssn
      t.integer :client_id
      t.integer :room_num

      t.timestamps
    end
  end
end
