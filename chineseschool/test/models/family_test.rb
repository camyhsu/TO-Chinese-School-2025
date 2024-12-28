require "test_helper"

class FamilyTest < ActiveSupport::TestCase
  test "belongs to one address" do
    assert_equal addresses(:one), families(:one).address
  end
end
