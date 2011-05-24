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

      final_query = nil

      if email.present? && postcodes.blank?
        final_query = where("email #{email_query_condition}", "%#{email}%")
      elsif email.present? && postcodes.present?
        final_query = joins(:postcode).where("email #{email_query_condition} AND postcodes.number #{postcode_query_condition}", "%#{email}%", postcode_numbers_array)
      elsif email.blank? && postcodes.present?
        final_query = joins(:postcode).where("postcodes.number #{postcode_query_condition}",  postcode_numbers_array)
      end

      final_query
    end
  end
end
