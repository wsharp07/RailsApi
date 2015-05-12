class CreateRmas < ActiveRecord::Migration
  def change
    create_table :rmas do |t|
      t.integer :customer_id
      t.string :rma_number
      t.string :serial_number
      t.integer :hardware_type
      t.datetime :issued_on
      t.string :reference_number
      t.integer :status

      t.timestamps null: false
    end
  end
end
