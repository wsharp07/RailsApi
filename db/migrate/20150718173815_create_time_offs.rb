class CreateTimeOffs < ActiveRecord::Migration
  def change
    create_table :time_offs do |t|
      t.column :user_id, :int, :null => false
      t.column :request_type_id, :int, :null => false
      t.column :request_start_date, :datetime, :null => false
      t.column :request_end_date, :datetime, :null => false
      t.column :status, :int, :null => false
      t.column :comments, :string
      t.timestamps null: false
    end
  end
end
