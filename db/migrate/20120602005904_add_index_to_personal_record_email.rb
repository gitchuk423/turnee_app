class AddIndexToPersonalRecordEmail < ActiveRecord::Migration
  def change
    add_index :personal_records, :email, unique: true
  end
end
