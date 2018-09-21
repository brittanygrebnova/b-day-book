class AddUserIdToBirthdays < ActiveRecord::Migration
  def change
    add_column :birthdays, :user_id, :integer
  end
end
