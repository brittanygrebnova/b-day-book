class AddUserIdToBirthdays < ActiveRecord::Migration[4.2]
  def change
    add_column :birthdays, :user_id, :integer
  end
end
