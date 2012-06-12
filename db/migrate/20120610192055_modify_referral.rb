class ModifyReferral < ActiveRecord::Migration
  def up
    add_column :referrals, :referral_name, :string
  end

  def down
    remove_column :referrals, :referral_name
  end
end
