class CreateActivityTypes < ActiveRecord::Migration
  def change
    create_table :activity_types do |t|
      t.string :name
      t.integer :tag

      t.timestamps
    end
    add_index :activity_types, :tag, :unique => true
  end
end
