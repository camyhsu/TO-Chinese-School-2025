require "test_helper"

class RegistrationPreferenceTest < ActiveSupport::TestCase
  test "valid registration preference can be saved" do
    valid_registration_preference = random_registration_preference
    assert valid_registration_preference.save
  end

  test "belongs to a student" do
    assert_equal people(:george), registration_preferences(:george_one).student
  end

  test "invalid if no student" do
    registration_preference_without_student = random_registration_preference
    assert registration_preference_without_student.valid?
    registration_preference_without_student.student = nil
    assert_not registration_preference_without_student.valid?
  end

  test "invalid if the student does not exist" do
    registration_preference_without_student = random_registration_preference
    assert registration_preference_without_student.valid?
    registration_preference_without_student.student_id = 1000 # pointing to a person id not in the fixtures
    assert_not registration_preference_without_student.valid?
  end

  test "belongs to an entered by person" do
    assert_equal people(:jane), registration_preferences(:george_one).entered_by
  end

  test "invalid if no entered by person" do
    registration_preference_without_entered_by = random_registration_preference
    assert registration_preference_without_entered_by.valid?
    registration_preference_without_entered_by.entered_by = nil
    assert_not registration_preference_without_entered_by.valid?
  end

  test "invalid if the entered by person does not exist" do
    registration_preference_without_entered_by = random_registration_preference
    assert registration_preference_without_entered_by.valid?
    registration_preference_without_entered_by.entered_by_id = 1000 # pointing to a person id not in the fixtures
    assert_not registration_preference_without_entered_by.valid?
  end

  test "belongs to a grade" do
    assert_equal grades(:pre_grade), registration_preferences(:george_one).grade
  end

  test "invalid if no grade" do
    registration_preference_without_grade = random_registration_preference
    assert registration_preference_without_grade.valid?
    registration_preference_without_grade.grade = nil
    assert_not registration_preference_without_grade.valid?
  end

  test "invalid if the grade does not exist" do
    registration_preference_without_grade = random_registration_preference
    assert registration_preference_without_grade.valid?
    registration_preference_without_grade.grade_id = 1000 # pointing to a grade id not in the fixtures
    assert_not registration_preference_without_grade.valid?
  end

  test "belongs to a previous grade" do
    assert_equal grades(:pre_grade), registration_preferences(:george_two).previous_grade
  end

  test "valid if no previous grade" do
    registration_preference_without_previous_grade = random_registration_preference
    registration_preference_without_previous_grade.grade = nil
    assert_not registration_preference_without_previous_grade.valid?
  end

  private
  def random_registration_preference
    RegistrationPreference.new(student: people(:george),
                               entered_by: people(:jane),
                               grade_id: 1)
  end
end
