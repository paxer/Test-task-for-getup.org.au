class Person < ActiveRecord::Base
  belongs_to :postcode
  validates :name, :postcode_id, :presence => true, :length => {:maximum => 50}
  validates :email, :presence => true, :email => true

  def self.search(email_condition, email, postcode_condition, postcodes)
    return includes(:postcode).all if email.blank? && postcodes.blank?

    r = self
    if postcodes.present?
      postcode_numbers_array = postcodes.split(",").collect { |p| p.to_i }
      postcode_query_condition = (postcode_condition == "not_from" ? " NOT IN (?)" : " IN (?)")
      r = r.joins(:postcode).where("postcodes.number #{postcode_query_condition}", postcode_numbers_array)
    end

    if email.present?
      email_query_condition = (email_condition == "not_like" ? " NOT LIKE ?" : " LIKE ?")
      r = r.where("email #{email_query_condition}", "%#{email}%")
    end
    r
  end
end