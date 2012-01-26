class CreateRecoverPasswords < ActiveRecord::Migration
  def change
    create_table :recover_passwords do |t|
      t.string :token
      t.integer :user_id

      t.timestamps
    end
    add_index :recover_passwords, :user_id
    add_index :recover_passwords, :token, :unique => true
  end
end
