class FixSchoolColumnName < ActiveRecord::Migration
  def up
  end

  def down
  end
  
  def change
    rename_column :schools, :personal_record_id, :professional_record_id
  end

end
