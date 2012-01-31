class AddBirthDateAndGenderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birth_date, :datetime
    add_column :users, :gender_id, :integer
  end
end
