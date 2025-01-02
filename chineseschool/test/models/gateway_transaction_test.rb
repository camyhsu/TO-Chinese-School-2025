require "test_helper"

class GatewayTransactionTest < ActiveSupport::TestCase
  test "valid gateway transaction can be saved" do
    valid_gateway_transaction = random_gateway_transaction
    assert valid_gateway_transaction.save
  end

  test "invalid if no amount in cents" do
    gateway_transaction_without_amount = random_gateway_transaction
    gateway_transaction_without_amount.amount_in_cents = nil
    assert_not gateway_transaction_without_amount.valid?
  end

  test "invalid if amount in cents is not an integer" do
    gateway_transaction_with_non_integer_amount = random_gateway_transaction
    gateway_transaction_with_non_integer_amount.amount_in_cents = SecureRandom.random_number
    assert_not gateway_transaction_with_non_integer_amount.valid?
  end

  test "invalid if amount in cents is negative" do
    gateway_transaction_with_negative_amount = random_gateway_transaction
    gateway_transaction_with_negative_amount.amount_in_cents = - TestRandom.integer_from_0_to_exclusive(100000)
    assert_not gateway_transaction_with_negative_amount.valid?
  end

  test "invalid if no credit card type" do
    gateway_transaction_without_credit_card_type = random_gateway_transaction
    gateway_transaction_without_credit_card_type.credit_card_type = " "
    assert_not gateway_transaction_without_credit_card_type.valid?
  end

  # Only validate the presence of the last digits but not the formatting, since this is given by an external library
  test "invalid if no credit card last digits" do
    gateway_transaction_without_credit_card_last_digits = random_gateway_transaction
    gateway_transaction_without_credit_card_last_digits.credit_card_last_digits = " "
    assert_not gateway_transaction_without_credit_card_last_digits.valid?
  end

  test "belongs to a registration payment" do
    assert_equal registration_payments(:paid_one), gateway_transactions(:failed).registration_payment
  end

  test "invalid if no registration payment" do
    gateway_transaction_without_registration_payment = random_gateway_transaction
    assert gateway_transaction_without_registration_payment.valid?
    gateway_transaction_without_registration_payment.registration_payment = nil
    assert_not gateway_transaction_without_registration_payment.valid?
  end

  test "invalid if the registration payment does not exist" do
    gateway_transaction_without_registration_payment = random_gateway_transaction
    assert gateway_transaction_without_registration_payment.valid?
    gateway_transaction_without_registration_payment.registration_payment_id = 1000 # pointing to a registration payment id not in the fixtures
    assert_not gateway_transaction_without_registration_payment.valid?
  end

  private
  def random_gateway_transaction
    GatewayTransaction.new(registration_payment: registration_payments(:paid_one),
                           amount_in_cents: TestRandom.integer_from_0_to_exclusive(100000),
                           credit_card_type: TestRandom.alphanumeric(5),
                           credit_card_last_digits: TestRandom.numeric(4))
  end
end
