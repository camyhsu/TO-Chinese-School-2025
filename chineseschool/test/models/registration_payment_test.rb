require "test_helper"

class RegistrationPaymentTest < ActiveSupport::TestCase
  test "valid registration payment can be saved" do
    valid_registration_payment = random_registration_payment
    assert valid_registration_payment.save
  end

  test "invalid if no elective class due in cents" do
    registration_payment_without_elective_class_due = random_registration_payment
    registration_payment_without_elective_class_due.elective_class_due_in_cents = nil
    assert_not registration_payment_without_elective_class_due.valid?
  end

  test "invalid if elective class due in cents is not an integer" do
    registration_payment_with_non_integer_elective_class_due = random_registration_payment
    registration_payment_with_non_integer_elective_class_due.elective_class_due_in_cents = SecureRandom.random_number
    assert_not registration_payment_with_non_integer_elective_class_due.valid?
  end

  test "invalid if elective class due in cents is negative" do
    registration_payment_with_negative_elective_class_due = random_registration_payment
    registration_payment_with_negative_elective_class_due.elective_class_due_in_cents = - TestRandom.integer_from_0_to_exclusive(100000)
    assert_not registration_payment_with_negative_elective_class_due.valid?
  end

  test "invalid if no pva due in cents" do
    registration_payment_without_pva_due = random_registration_payment
    registration_payment_without_pva_due.pva_due_in_cents = nil
    assert_not registration_payment_without_pva_due.valid?
  end

  test "invalid if pva due in cents is not an integer" do
    registration_payment_with_non_integer_pva_due = random_registration_payment
    registration_payment_with_non_integer_pva_due.pva_due_in_cents = SecureRandom.random_number
    assert_not registration_payment_with_non_integer_pva_due.valid?
  end

  test "invalid if pva due in cents is negative" do
    registration_payment_with_negative_pva_due = random_registration_payment
    registration_payment_with_negative_pva_due.pva_due_in_cents = - TestRandom.integer_from_0_to_exclusive(100000)
    assert_not registration_payment_with_negative_pva_due.valid?
  end

  test "invalid if no ccca due in cents" do
    registration_payment_without_ccca_due = random_registration_payment
    registration_payment_without_ccca_due.ccca_due_in_cents = nil
    assert_not registration_payment_without_ccca_due.valid?
  end

  test "invalid if ccca due in cents is not an integer" do
    registration_payment_with_non_integer_ccca_due = random_registration_payment
    registration_payment_with_non_integer_ccca_due.ccca_due_in_cents = SecureRandom.random_number
    assert_not registration_payment_with_non_integer_ccca_due.valid?
  end

  test "invalid if ccca due in cents is negative" do
    registration_payment_with_negative_ccca_due = random_registration_payment
    registration_payment_with_negative_ccca_due.ccca_due_in_cents = - TestRandom.integer_from_0_to_exclusive(100000)
    assert_not registration_payment_with_negative_ccca_due.valid?
  end

  test "invalid if no grand total in cents" do
    registration_payment_without_grand_total = random_registration_payment
    registration_payment_without_grand_total.grand_total_in_cents = nil
    assert_not registration_payment_without_grand_total.valid?
  end

  test "invalid if grand total in cents is not an integer" do
    registration_payment_with_non_integer_grand_total = random_registration_payment
    registration_payment_with_non_integer_grand_total.grand_total_in_cents = SecureRandom.random_number
    assert_not registration_payment_with_non_integer_grand_total.valid?
  end

  test "invalid if grand total in cents is negative" do
    registration_payment_with_negative_grand_total = random_registration_payment
    registration_payment_with_negative_grand_total.grand_total_in_cents = - TestRandom.integer_from_0_to_exclusive(100000)
    assert_not registration_payment_with_negative_grand_total.valid?
  end

  test "belongs to a paid by person" do
    assert_equal people(:jane), registration_payments(:paid_one).paid_by
  end

  test "invalid if no paid by person" do
    registration_payment_without_paid_by = random_registration_payment
    assert registration_payment_without_paid_by.valid?
    registration_payment_without_paid_by.paid_by = nil
    assert_not registration_payment_without_paid_by.valid?
  end

  test "invalid if the paid by person does not exist" do
    registration_payment_without_paid_by = random_registration_payment
    assert registration_payment_without_paid_by.valid?
    registration_payment_without_paid_by.paid_by_id = 1000 # pointing to a person id not in the fixtures
    assert_not registration_payment_without_paid_by.valid?
  end

  test "has many gateway transactions" do
    assert_includes registration_payments(:paid_one).gateway_transactions, gateway_transactions(:failed)
    assert_includes registration_payments(:paid_one).gateway_transactions, gateway_transactions(:succeeded)
    assert_not_includes registration_payments(:paid_one).gateway_transactions, gateway_transactions(:errored)
  end

  test "valid if no gateway transactions" do
    registration_payment_without_gateway_transactions = random_registration_payment
    registration_payment_without_gateway_transactions.gateway_transactions = []
    assert registration_payment_without_gateway_transactions.valid?
  end

  private
  def random_registration_payment
    RegistrationPayment.new(paid_by: people(:jane),
                            pva_due_in_cents: TestRandom.integer_from_0_to_exclusive(100000),
                            ccca_due_in_cents: TestRandom.integer_from_0_to_exclusive(100000),
                            grand_total_in_cents: TestRandom.integer_from_0_to_exclusive(100000),
                            paid: Faker::Boolean.boolean,
                            request_in_person: false,
                            elective_class_due_in_cents: TestRandom.integer_from_0_to_exclusive(100000))
  end
end
