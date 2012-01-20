class CreateHeartRateSummaries < ActiveRecord::Migration
  def change
    create_table :heart_rate_summaries do |t|
      t.date :date
      t.integer :occurrences
      t.references :user
      t.references :heart_rate_type

      t.timestamps
    end
    add_index :heart_rate_summaries, :user_id
    add_index :heart_rate_summaries, :heart_rate_type_id
  end
end
