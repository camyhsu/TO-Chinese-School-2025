require "test_helper"

class PersonTest < ActiveSupport::TestCase
  test "valid person can be saved" do
    valid_person = random_person
    assert valid_person.save
  end

  test "invalid if no english first name" do
    person_without_english_first_name = random_person
    person_without_english_first_name.english_first_name = " "
    assert_not person_without_english_first_name.valid?
  end

  test "invalid if no english last name" do
    person_without_english_last_name = random_person
    person_without_english_last_name.english_last_name = " "
    assert_not person_without_english_last_name.valid?
  end

  test "invalid if gender is not one of the valid values" do
    person_without_valid_gender = random_person
    person_without_valid_gender.gender = nil
    assert_not person_without_valid_gender.valid?
    person_without_valid_gender.gender = "Some Invalid Role"
    assert_not person_without_valid_gender.valid?
  end

  test "belongs to one address" do
    assert_equal addresses(:one), people(:jane).address
  end

  test "valid if belongs to no address" do
    person_without_address = random_person
    person_without_address.address = nil
    assert person_without_address.valid?
  end

  test "has many instructor assignments" do
    assert_includes people(:jane).instructor_assignments, instructor_assignments(:one)
    assert_includes people(:jane).instructor_assignments, instructor_assignments(:three)
    assert_not_includes people(:jane).instructor_assignments, instructor_assignments(:two)
  end

  test "valid if no instructor assignments" do
    person_without_instructor_assignments = random_person
    person_without_instructor_assignments.instructor_assignments = []
    assert person_without_instructor_assignments.valid?
  end

  test "has many registration preferences" do
    assert_includes people(:george).registration_preferences, registration_preferences(:george_one)
    assert_includes people(:george).registration_preferences, registration_preferences(:george_two)
    assert_not_includes people(:george).registration_preferences, registration_preferences(:mary_one)
  end

  test "valid if no registration preferences" do
    person_without_registration_preferences = random_person
    person_without_registration_preferences.registration_preferences = []
    assert person_without_registration_preferences.valid?
  end

  private
  def random_person
    Person.new(english_first_name: Faker::Name.first_name,
               english_last_name: Faker::Name.last_name,
               gender: Person::GENDERS.sample)
  end
end
