class ChangeAttorneyIdToReferralIdInClient < ActiveRecord::Migration
  def up
      rename_column :clients, :attorney_id, :referral_id
  end

  def down
      rename_column :clients, :referral_id, :attorney_id
  end
end
