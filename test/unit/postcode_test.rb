require 'test_helper'

class PostcodeTest < ActiveSupport::TestCase
  def setup
    @postcode = Postcode.new
    @deathstar = postcodes(:one)
  end

  def teardown
    @postcode = nil
    @deathstar = nil
  end

  test "should not add new postcode without a number" do
    @postcode.suburb = "test_sub"
    assert !@postcode.save, "Added postcode without a number"
  end

  test "should not add new postcode without a suburb" do
    @postcode.number = 2000
    assert !@postcode.save, "Added postcode without a suburb"
  end

  test "should add new postcode with correct data" do
    @postcode.number = 2000
    @postcode.suburb = "test"
    assert @postcode.save, "Postcode with correct data has not been saved"
    assert_equal @postcode.number, 2000
    assert_equal @postcode.suburb, "test"
  end

  test "should update postcode correctly" do
    @deathstar.number = 3000
    @deathstar.suburb = "Not a death star"
    assert @deathstar.save, "Postcode with correct data has not been updated"
    assert_equal @deathstar.number, 3000
    assert_equal @deathstar.suburb, "Not a death star"
  end


end
