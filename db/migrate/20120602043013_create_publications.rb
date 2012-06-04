class CreatePublications < ActiveRecord::Migration
  def change
    add_column :publications, :professional_record_id, :integer
  end
end
