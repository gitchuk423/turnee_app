class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.integer :referred_from_attorney_id
      t.integer :referred_to_attorney_id
      t.integer :status
      t.integer :client_id
      t.text :public_comments
      t.text :private_comments

      t.timestamps
    end
  end
end
