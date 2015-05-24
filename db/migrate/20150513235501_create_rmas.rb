class CreateRmas < ActiveRecord::Migration
  def change
    create_table :rmas do |t|
      t.column :rma_number, :string, :null => false
      t.column :serial_number, :string
      t.column :reference_number, :string
      t.column :tracking_number, :string
      t.column :status, :int
      t.column :comments, :string
      t.column :received_at, :datetime
      t.column :closed_at, :datetime
      t.timestamps
    end
  end
end
