require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def setup
    @person = Person.new
    @darth = people(:one)
  end

  def teardown
    @person = nil
    @darth = nil
  end

  test "should not add new person without a name" do
    @person.postcode_id = 1
    @person.email = "test@email.com"
    assert !@person.save, "Added person without a name"
  end

  test "should not add new person without a postcode" do
    @person.name = "Darth"
    @person.email = "test@email.com"
    assert !@person.save, "Added person without a postcode"
  end

  test "should not add new person without a email" do
    @person.name = "Darth"
    @person.postcode_id = 1
    assert !@person.save, "Added person without a postcode"
  end

  test "email should be correct" do
    @person.name = "Darth"
    @person.postcode_id = 1
    @person.email = "not_correct_email"
    assert !@person.save, "Added person with an incorrect email"
  end

  test "should save person with correct data" do
    @person.name = "Darth"
    @person.postcode_id = 1
    @person.email = "info@deathstar.com"
    assert @person.save, "Person with correct data has not been saved"
    assert_equal @person.name, "Darth"
    assert_equal @person.postcode_id, 1
    assert_equal @person.email, "info@deathstar.com"
  end

  test "should update person data correctly" do
    @darth.name = "Luke"
    @darth.postcode_id = 2
    @darth.email = "luke@deathstar.com"
    assert @darth.save, "Person with correct data has not been saved"
    assert_equal @darth.name, "Luke"
    assert_equal @darth.postcode_id, 2
    assert_equal @darth.email, "luke@deathstar.com"
  end

  test "search should return correct values" do
    email_condition = "like"
    email = "darth@deathstar.com"
    postcode_condition = "from"
    postcodes = "2000"
    p = Person.search(email_condition, email, postcode_condition, postcodes).first
    assert_equal p.name, "Darth Vader"

    email_condition = "not_like"
    email = ""
    postcode_condition = "from"
    postcodes = "3000"
    p = Person.search(email_condition, email, postcode_condition, postcodes).first
    assert_equal "Chuck Norris", p.name

    email_condition = "like"
    email = "watchingyou"
    postcode_condition = "from"
    postcodes = ""
    p = Person.search(email_condition, email, postcode_condition, postcodes).first
    assert_equal "Chuck Norris", p.name

  end

  test "search without parameters should return all records" do
    email_condition = "not_like"
    email = ""
    postcode_condition = "from"
    postcodes = ""
    p2 = Person.search(email_condition, email, postcode_condition, postcodes)
    assert_equal p2.size, 2
  end

end