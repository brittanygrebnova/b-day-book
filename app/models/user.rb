class User < ActiveRecord::Base
  has_many :birthdays
  has_secure_password
end