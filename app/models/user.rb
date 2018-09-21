class User < ActiveRecord::Base
  has_many :birthdays
end