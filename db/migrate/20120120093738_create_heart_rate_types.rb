class CreateHeartRateTypes < ActiveRecord::Migration
  def change
    create_table :heart_rate_types do |t|
      t.string :name
      t.integer :min_value
      t.integer :max_value

      t.timestamps
    end
  end
end
