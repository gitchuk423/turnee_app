class CreateAttorneys < ActiveRecord::Migration
  def change
    create_table :attorneys do |t|
      t.timestamps
    end
    
    create_table :personal_records do |t|
     t.string :attorney_id
     t.string :email
     t.string :first_name
     t.string :last_name
     t.timestamps
    end
  end
end
