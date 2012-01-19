class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :display_name
      t.string :email
      t.integer :last_heart_rate
      t.boolean :online_status
      t.integer :last_battery_value

      t.timestamps
    end
  end
end
