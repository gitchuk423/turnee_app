class AddPositionToProfessionalExperience < ActiveRecord::Migration
  def change
    add_column :professional_experiences, :position, :string
    add_column :professional_experiences, :current, :boolean, default: false
  end
end
