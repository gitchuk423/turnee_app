class AddPasswordDigestToAttorneys < ActiveRecord::Migration
  def change
    add_column :attorneys, :password_digest, :string
  end
end
