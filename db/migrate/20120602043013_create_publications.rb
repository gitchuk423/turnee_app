class CreatePublications < ActiveRecord::Migration
  def change
    
      create_table :publications do |t|

      t.integer :professional_record_id

      t.timestamps
    end
  
  
  end
end
