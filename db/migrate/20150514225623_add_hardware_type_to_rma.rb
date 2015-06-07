class AddHardwareTypeToRma < ActiveRecord::Migration
  def change
    add_column :rmas, :hardware_type_id, :integer
    add_index :rmas, :hardware_type_id
  end
end
