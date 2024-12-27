require "test_helper"

class AddressTest < ActiveSupport::TestCase
  test "valid address can be saved" do
    valid_address = random_address
    assert valid_address.save
  end

  test "invalid if no street" do
    address_without_street = random_address
    address_without_street.street = " "
    assert_not address_without_street.valid?
  end

  test "invalid if no city" do
    address_without_city = random_address
    address_without_city.city = " "
    assert_not address_without_city.valid?
  end

  test "invalid if no state" do
    address_without_state = random_address
    address_without_state.state = " "
    assert_not address_without_state.valid?
  end

  test "invalid if no email" do
    address_without_email = random_address
    address_without_email.email = " "
    assert_not address_without_email.valid?
  end

  test "invalid if no zipcode" do
    address_without_zipcode = random_address
    address_without_zipcode.zipcode = nil
    assert_not address_without_zipcode.valid?
  end

  test "valid zipcode is 5 digits long" do
    address = random_address
    address.zipcode = TestRandom.numeric(4)
    assert_not address.valid?
    address.zipcode = TestRandom.numeric(6)
    assert_not address.valid?
  end

  test "valid zipcode is digits only" do
    address = random_address
    address.zipcode = TestRandom.alphanumeric(5)
    assert_not address.valid?
  end

  test "invalid if no home phone" do
    address_without_home_phone = random_address
    address_without_home_phone.home_phone = nil
    assert_not address_without_home_phone.valid?
  end

  test "valid home phone is 10 digits long" do
    address = random_address
    address.home_phone = TestRandom.numeric(9)
    assert_not address.valid?
    address.home_phone = TestRandom.numeric(11)
    assert_not address.valid?
  end

  test "valid home phone is digits only" do
    address = random_address
    address.home_phone = TestRandom.alphanumeric(10)
    assert_not address.valid?
  end

  test "home phone is cleaned before validation" do
    address = random_address
    area_code = TestRandom.numeric(3)
    first_section = TestRandom.numeric(3)
    second_section = TestRandom.numeric(4)
    address.home_phone = "(#{area_code}) #{first_section}-#{second_section}"
    assert address.valid?
    assert_equal "#{area_code}#{first_section}#{second_section}", address.home_phone
    address.home_phone = "#{area_code}.#{first_section}.#{second_section}"
    assert address.valid?
    assert_equal "#{area_code}#{first_section}#{second_section}", address.home_phone
  end

  test "valid if no cell phone" do
    address_without_cell_phone = random_address
    address_without_cell_phone.cell_phone = nil
    assert address_without_cell_phone.valid?
    address_without_cell_phone.cell_phone = " "
    assert address_without_cell_phone.valid?
  end

  test "valid cell phone is 10 digits long" do
    address = random_address
    address.cell_phone = TestRandom.numeric(9)
    assert_not address.valid?
    address.cell_phone = TestRandom.numeric(11)
    assert_not address.valid?
  end

  test "valid cell phone is digits only" do
    address = random_address
    address.cell_phone = TestRandom.alphanumeric(10)
    assert_not address.valid?
  end

  test "cell phone is cleaned before validation" do
    address = random_address
    area_code = TestRandom.numeric(3)
    first_section = TestRandom.numeric(3)
    second_section = TestRandom.numeric(4)
    address.cell_phone = "(#{area_code}) #{first_section}-#{second_section}"
    assert address.valid?
    assert_equal "#{area_code}#{first_section}#{second_section}", address.cell_phone
    address.cell_phone = "#{area_code}.#{first_section}.#{second_section}"
    assert address.valid?
    assert_equal "#{area_code}#{first_section}#{second_section}", address.cell_phone
  end

  private
  def random_address
    Address.new(city: TestRandom.alphanumeric(13),
                email: TestRandom.alphanumeric(17),
                home_phone: TestRandom.numeric(10),
                state: TestRandom.alphanumeric(9),
                street: TestRandom.alphanumeric(25),
                zipcode: TestRandom.numeric(5))
  end
end