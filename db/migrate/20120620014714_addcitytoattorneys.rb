class Addcitytoattorneys < ActiveRecord::Migration
  def up
    add_column :attorneys, :city, :string
  end

  def down
    remove_column :attorneys, :city
  end
end
