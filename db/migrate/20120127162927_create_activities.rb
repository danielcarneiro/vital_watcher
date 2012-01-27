class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :activity_type
      t.references :user
      t.datetime :timestamp

      t.timestamps
    end
    add_index :activities, :activity_type_id
    add_index :activities, :user_id
  end
end
