class Person < ActiveRecord::Base
  has_one :postcode
  validates :name, :postcode_id, :presence => true, :length => {:maximum => 50}
  validates :email, :presence => true, :email => true

  def self.search(email, condition, postcodes)
    if email.blank? && postcodes.blank?
      all
    elsif email.present? && postcodes.blank?
      where("email LIKE ?", "%#{email}%")
    end
  end

end
