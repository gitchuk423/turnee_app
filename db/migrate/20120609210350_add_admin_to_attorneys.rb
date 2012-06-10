class AddAdminToAttorneys < ActiveRecord::Migration
  def change
    add_column :attorneys, :admin, :boolean, default: false
  end
end
