class CreateAttorneys < ActiveRecord::Migration
  def change
    create_table :attorneys do |t|

      t.timestamps
    end
  end
end
