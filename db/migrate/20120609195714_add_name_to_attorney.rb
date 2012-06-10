class AddNameToAttorney < ActiveRecord::Migration
  def up
    add_column :attorneys, :first_name, :string
    add_column :attorneys, :last_name, :string
    add_column :attorneys, :middle_initial, :string
  end
  
  def down
    remove_column :attorneys, :first_name
    remove_column :attorneys, :last_name
    remove_column :attorneys, :middle_initial
  
  end
end
