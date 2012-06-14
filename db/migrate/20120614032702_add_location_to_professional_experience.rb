class AddLocationToProfessionalExperience < ActiveRecord::Migration
  def change
    add_column :professional_experiences, :city, :string
    add_column :professional_experiences, :state, :string
    add_column :professional_experiences, :country, :string
    
  end
end
