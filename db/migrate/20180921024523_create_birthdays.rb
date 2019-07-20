class CreateBirthdays < ActiveRecord::Migration[4.2]
  def change
    create_table :birthdays do |t|
      t.string :name
      t.date :date
    end
  end
end
