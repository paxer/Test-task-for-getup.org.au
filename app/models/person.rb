class Person < ActiveRecord::Base
  has_one :postcode
  validates :name, :postcode_id, :presence => true, :length => { :maximum => 50 }
  validates :email, :presence => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
end
