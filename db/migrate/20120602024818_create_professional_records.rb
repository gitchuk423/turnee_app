class CreateProfessionalRecords < ActiveRecord::Migration
  def change
    create_table :professional_records do |t|
      t.string :experience
      t.string :firm_name
      t.integer :attorney_id

      t.timestamps
    end
  end
end
