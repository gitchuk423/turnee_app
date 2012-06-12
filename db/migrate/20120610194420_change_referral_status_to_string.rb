
class ChangeReferralStatusToString < ActiveRecord::Migration
  def up
      remove_column :referrals, :status
      add_column :referrals, :status, :string
  end

  def down
      remove_column :referrals, :status
      add_column :referrals, :status, :integer
  end
end
