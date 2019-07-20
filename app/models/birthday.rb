require 'active_record'

class Birthday < ActiveRecord::Base
  belongs_to :user
end
