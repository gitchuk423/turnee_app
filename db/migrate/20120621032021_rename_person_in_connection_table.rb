class RenamePersonInConnectionTable < ActiveRecord::Migration
  def up
    rename_column :connections, :person_id, :attorney_id
  end

  def down
    rename_column :connections, :attorney_id, :person_id
  end
end

