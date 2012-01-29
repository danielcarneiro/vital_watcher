class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :event_type
      t.references :user
      t.datetime :timestamp
      t.integer :value
      t.boolean :handled

      t.timestamps
    end
    add_index :events, :event_type_id
    add_index :events, :user_id
  end
end
