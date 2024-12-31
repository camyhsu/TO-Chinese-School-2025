require "test_helper"

class FamilyTest < ActiveSupport::TestCase
  test "valid family can be saved" do
    valid_family = families(:doe)
    assert valid_family.save
  end

  test "belongs to one address" do
    assert_equal addresses(:one), families(:doe).address
  end

  test "invalid if belongs to no address" do
    family_without_address = families(:doe)
    assert family_without_address.valid?
    family_without_address.address = nil
    assert_not family_without_address.valid?
  end

  test "invalid if the address does not exist" do
    family_without_address = families(:doe)
    assert family_without_address.valid?
    family_without_address.address_id = 1000 # pointing to an address id not in the fixtures
    assert_not family_without_address.valid?
  end

  test "belongs to a parent one" do
    assert_equal people(:jane), families(:doe).parent_one
  end

  test "invalid if no parent one" do
    family_without_parent_one = families(:doe)
    assert family_without_parent_one.valid?
    family_without_parent_one.parent_one = nil
    assert_not family_without_parent_one.valid?
  end

  test "invalid if the parent one does not exist" do
    family_without_parent_one = families(:doe)
    assert family_without_parent_one.valid?
    family_without_parent_one.parent_one_id = 1000 # pointing to a person id not in the fixtures
    assert_not family_without_parent_one.valid?
  end

  test "belongs to a parent two" do
    assert_equal people(:john), families(:doe).parent_two
  end

  test "valid if no parent two" do
    family_without_parent_two = families(:doe)
    assert family_without_parent_two.valid?
    family_without_parent_two.parent_two = nil
    assert family_without_parent_two.valid?
  end

  test "has many children" do
    assert_includes families(:doe).children, people(:george)
    assert_includes families(:doe).children, people(:mary)
    assert_includes families(:doe).children, people(:karl)
    assert_not_includes families(:doe).children, people(:jane)
  end

  test "valid if no children" do
    family_without_children = families(:doe)
    assert family_without_children.valid?
    family_without_children.children = []
    assert family_without_children.valid?
  end
end
