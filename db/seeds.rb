User.destroy_all
Birthday.destroy_all
user = User.create(:username => 'brittany', :email => 'brittanygrebnova@gmail.com', :password => 'mila2013')
user.birthdays.create(:name => 'Mila', :date => '2013-09-25')
user.birthdays.create(:name => 'Damir', :date => '2017-09-14')
user.birthdays.create(:name => 'Arseniy', :date => '1986-08-14')
