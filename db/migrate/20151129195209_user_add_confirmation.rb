class UserAddConfirmation < ActiveRecord::Migration
  def change
  	add_column :users, :confirmation, :boolean, :default => false, :null => false
  end
end
