class CreateRequestTypes < ActiveRecord::Migration
  def change
    create_table :request_types do |t|
      t.column :name, :string, :null => false
      t.timestamps null: false
    end
  end
end
