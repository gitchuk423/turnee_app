class AddPersonalInfoToAttorney < ActiveRecord::Migration
  def change
      add_column :attorneys, :country, :string
      add_column :attorneys, :state, :string
      add_column :attorneys, :attorney_type, :string
  end
end
