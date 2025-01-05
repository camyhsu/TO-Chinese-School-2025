require "test_helper"

class RoleTest < ActiveSupport::TestCase
  test "valid role can be saved" do
    valid_role = random_role
    assert valid_role.save
  end

  test "invalid if no name" do
    role_without_name = random_role
    role_without_name.name = " "
    assert_not role_without_name.valid?
  end

  test "invalid if the name is not unique" do
    existing_role = random_role
    existing_role.save
    role_with_duplicated_name = Role.new(name: existing_role.name)
    assert_not role_with_duplicated_name.valid?
  end

  test "has many rights" do
    assert_includes roles(:registration).rights, rights(:create_new_school_class)
    assert_includes roles(:registration).rights, rights(:create_school_year)
    assert_not_includes roles(:registration).rights, rights(:accounting_payment)
  end

  test "valid if no right" do
    role_without_right = roles(:ccca_staff)
    assert role_without_right.valid?
    role_without_right.rights = []
    assert role_without_right.valid?
  end

  test "has a rights collection that is ordered by controller and action values" do
    assert_equal roles(:registration).rights[0], rights(:create_new_school_class)
    assert_equal roles(:registration).rights[1], rights(:list_school_year)
    assert_equal roles(:registration).rights[2], rights(:create_school_year)
    assert_equal roles(:registration).rights[3], rights(:student_list)
  end

  private
  def random_role
    Role.new(name: TestRandom.alphanumeric(13))
  end
end
