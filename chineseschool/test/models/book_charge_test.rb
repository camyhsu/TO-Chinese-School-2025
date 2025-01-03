require "test_helper"

class BookChargeTest < ActiveSupport::TestCase
  test "valid book charge can be saved" do
    valid_book_charge = random_book_charge
    assert valid_book_charge.save
  end

  test "invalid if no book charge in cents" do
    book_charge_without_value = random_book_charge
    book_charge_without_value.book_charge_in_cents = nil
    assert_not book_charge_without_value.valid?
  end

  test "invalid if book charge in cents is not an integer" do
    non_integer_book_charge = random_book_charge
    non_integer_book_charge.book_charge_in_cents = SecureRandom.random_number
    assert_not non_integer_book_charge.valid?
  end

  test "invalid if book charge in cents is negative" do
    negative_book_charge = random_book_charge
    negative_book_charge.book_charge_in_cents = - TestRandom.integer_from_0_to_exclusive(100000)
    assert_not negative_book_charge.valid?
  end

  test "belongs to one grade" do
    assert_equal grades(:k_grade), book_charges(:one).grade
  end

  test "invalid if no grade" do
    book_charge_without_grade = random_book_charge
    assert book_charge_without_grade.valid?
    book_charge_without_grade.grade_id = nil
    assert_not book_charge_without_grade.valid?
  end

  test "invalid if the grade does not exist" do
    book_charge_without_grade = random_book_charge
    assert book_charge_without_grade.valid?
    book_charge_without_grade.grade_id = 1000 # pointing to a grade id not in the fixtures
    assert_not book_charge_without_grade.valid?
  end

  private
  def random_book_charge
    BookCharge.new(grade_id: 1,
                   school_year_id: TestRandom.integer_from_a_range(1..20),
                   book_charge_in_cents: TestRandom.integer_from_0_to_exclusive(100000))
  end
end
