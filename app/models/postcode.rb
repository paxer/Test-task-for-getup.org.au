class Postcode < ActiveRecord::Base
  belongs_to :person
  validates :number, :suburb, :presence => true, :length => { :maximum => 50 }
end
