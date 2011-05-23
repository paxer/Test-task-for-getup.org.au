class Person < ActiveRecord::Base
  has_one :postcode
  validates :name, :postcode_id, :presence => true, :length => { :maximum => 50 }
  validates :email, :presence => true, :email => true
end
