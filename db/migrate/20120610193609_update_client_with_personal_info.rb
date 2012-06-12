class UpdateClientWithPersonalInfo < ActiveRecord::Migration
  def up
    add_column :clients, :first_name, :string
    add_column :clients, :last_name, :string
    add_column :clients, :email, :string
    remove_column :clients, :personal_record_id
  end

  def down
    remove_column :clients, :first_name
    remove_column :clients, :last_name
    remove_column :clients, :email
    add_column :clients, :personal_record_id, :integer
  
  end
end
