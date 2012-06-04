class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.integer :attorney_id
      t.integer :personal_record_id

      t.timestamps
    end
  end
end
