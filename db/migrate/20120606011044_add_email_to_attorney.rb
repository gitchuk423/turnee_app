class AddEmailToAttorney < ActiveRecord::Migration
  def change
  	add_column "attorneys", "email", :string
  	add_index "attorneys", "email"
  end
end
