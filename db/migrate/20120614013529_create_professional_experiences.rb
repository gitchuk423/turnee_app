class CreateProfessionalExperiences < ActiveRecord::Migration
  def change
    create_table :professional_experiences do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :attorney_id
      t.timestamps
    end
  end
end
