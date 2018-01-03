class CreateReceptionists < ActiveRecord::Migration[5.0]
  def change
    create_table :receptionists do |t|
      t.integer :Ssn
      t.integer :Manager_ssn

      t.timestamps
    end
  end
end
