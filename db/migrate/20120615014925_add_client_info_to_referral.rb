class AddClientInfoToReferral < ActiveRecord::Migration
  def change
    add_column :referrals, :client_first_name, :string
    add_column :referrals, :client_last_name,  :string
    add_column :referrals, :client_email,  :string
    add_column :referrals, :client_phone,  :string
  end
end
