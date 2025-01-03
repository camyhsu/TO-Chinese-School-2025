require "test_helper"

class InstructorAssignmentTest < ActiveSupport::TestCase
  test "valid instructor assignment can be saved" do
    valid_instructor_assignment = random_instructor_assignment
    assert valid_instructor_assignment.save
  end

  test "invalid if no start date" do
    instructor_assignment_without_start_date = random_instructor_assignment
    instructor_assignment_without_start_date.start_date = nil
    assert_not instructor_assignment_without_start_date.valid?
  end

  test "invalid if no end date" do
    instructor_assignment_without_end_date = random_instructor_assignment
    instructor_assignment_without_end_date.end_date = nil
    assert_not instructor_assignment_without_end_date.valid?
  end

  test "invalid if the end date is before the start date" do
    instructor_assignment = random_instructor_assignment
    instructor_assignment.end_date = instructor_assignment.start_date - 1.day
    assert_not instructor_assignment.valid?
  end

  test "valid if the end date is the same as the start date" do
    instructor_assignment = random_instructor_assignment
    instructor_assignment.end_date = instructor_assignment.start_date
    assert instructor_assignment.valid?
  end

  test "invalid if role is not one of the valid values" do
    instructor_assignment_without_valid_role = random_instructor_assignment
    instructor_assignment_without_valid_role.role = nil
    assert_not instructor_assignment_without_valid_role.valid?
    instructor_assignment_without_valid_role.role = "Some Invalid Role"
    assert_not instructor_assignment_without_valid_role.valid?
  end

  test "belongs to an instructor" do
    assert_equal people(:jane), instructor_assignments(:one).instructor
  end

  test "invalid if no instructor" do
    instructor_assignment_without_instructor = random_instructor_assignment
    assert instructor_assignment_without_instructor.valid?
    instructor_assignment_without_instructor.instructor = nil
    assert_not instructor_assignment_without_instructor.valid?
  end

  test "invalid if the instructor does not exist" do
    instructor_assignment_without_instructor = random_instructor_assignment
    assert instructor_assignment_without_instructor.valid?
    instructor_assignment_without_instructor.instructor_id = 1000 # pointing to a person id not in the fixtures
    assert_not instructor_assignment_without_instructor.valid?
  end

  private
  def random_instructor_assignment
    InstructorAssignment.new(instructor: people(:jane),
                             start_date: Date.today - 1.week,
                             end_date: Date.today,
                             role: InstructorAssignment::ROLES.sample)
  end
end
