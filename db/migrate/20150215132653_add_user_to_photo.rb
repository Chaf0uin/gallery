class AddUserToPhoto < ActiveRecord::Migration
  def change
  	add_column :photos, :user_id, :integer, references: :users
  end
end
