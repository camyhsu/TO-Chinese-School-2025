require "test_helper"

class RightTest < ActiveSupport::TestCase
  test "valid right can be saved" do
    valid_right = random_right
    assert valid_right.save
  end

  test "invalid if no name" do
    right_without_name = random_right
    right_without_name.name = " "
    assert_not right_without_name.valid?
  end

  test "invalid if no controller" do
    right_without_controller = random_right
    right_without_controller.controller = " "
    assert_not right_without_controller.valid?
  end

  test "invalid if no action" do
    right_without_action = random_right
    right_without_action.action = " "
    assert_not right_without_action.valid?
  end

  private
  def random_right
    Right.new(name: TestRandom.alphanumeric(13),
              controller: TestRandom.alphanumeric(17),
              action: TestRandom.alphanumeric(7))
  end
end
