class Postcode < ActiveRecord::Base
  validates :number, :suburb, :presence => true, :length => { :maximum => 50 }
end
