class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.integer :room_num
      t.string :plan
      t.integer :num_of_beds

      t.timestamps
    end
  end
end
