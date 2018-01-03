class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.integer :national_id
      t.string :first_n
      t.string :last_n
      t.string :payment_type

      t.timestamps
    end
  end
end
