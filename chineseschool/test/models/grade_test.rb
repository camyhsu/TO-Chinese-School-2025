require "test_helper"

class GradeTest < ActiveSupport::TestCase
  test "belongs to the next grade" do
    assert_equal grades(:second_grade), grades(:first_grade).next_grade
  end

  test "has a previous grade" do
    assert_equal grades(:first_grade), grades(:second_grade).previous_grade
  end

  test "highest grade has no next grade" do
    assert_nil grades(:third_grade).next_grade
  end

  test "lowest grade has no previous grade" do
    assert_nil grades(:pre_grade).previous_grade
  end
end
