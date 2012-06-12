class RenameReferredToAttorneyId < ActiveRecord::Migration
  def up
    rename_column :referrals, :referred_from_attorney_id, :attorney_id
  end

  def down
  end
end
