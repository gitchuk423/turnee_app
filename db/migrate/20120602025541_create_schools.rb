class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :major
      t.integer :attorney_id
      t.integer :personal_record_id

      t.timestamps
    end
  end
end
