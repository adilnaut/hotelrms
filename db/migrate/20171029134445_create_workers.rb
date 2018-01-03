class CreateWorkers < ActiveRecord::Migration[5.0]
  def change
    create_table :workers do |t|
      t.integer :Ssn
      t.string :First
      t.string :Last
      t.integer :Salary

      t.timestamps
    end
  end
end
