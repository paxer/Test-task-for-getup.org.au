class Person < ActiveRecord::Base
  belongs_to :postcode
  validates :name, :postcode_id, :presence => true, :length => {:maximum => 50}
  validates :email, :presence => true, :email => true

  def self.search(email_condition, email, postcode_condition, postcodes)
    if email.blank? && postcodes.blank?
      includes(:postcode).all
    else
      postcode_numbers_array = postcodes.split(",").collect { |p| p.to_i }

      email_query_condition = " LIKE ?"
      email_query_condition = " NOT LIKE ?" if email_condition == "not_like"

      postcode_query_condition = " IN (?)"
      postcode_query_condition = " NOT IN (?)" if postcode_condition == "not_from"

      email_query = where("email #{email_query_condition}", "%#{email}%")
      postcode_query = joins(:postcode).where("postcodes.number #{postcode_query_condition}", postcode_numbers_array)
      postcode_and_email_query = joins(:postcode).where("email #{email_query_condition}", "%#{email}%").where("postcodes.number #{postcode_query_condition}", postcode_numbers_array)

      if email.present? && postcodes.present?
        postcode_and_email_query
      elsif email.present? && postcodes.blank?
        email_query
      else
        postcode_query
      end

    end
  end
end
