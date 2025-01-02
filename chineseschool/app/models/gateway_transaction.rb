class GatewayTransaction < ApplicationRecord
  belongs_to :registration_payment

  validates :credit_card_type, :credit_card_last_digits, presence: true
  validates :amount_in_cents, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
