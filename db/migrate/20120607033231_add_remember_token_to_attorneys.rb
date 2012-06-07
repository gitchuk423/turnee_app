class AddRememberTokenToAttorneys < ActiveRecord::Migration
  def change
  	add_column :attorneys, :remember_token, :string
    add_index  :attorneys, :remember_token
  end
end
