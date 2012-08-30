class AddLoginAmountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login_amount, :integer
  end
end
