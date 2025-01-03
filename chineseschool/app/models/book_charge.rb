class BookCharge < ApplicationRecord
  belongs_to :grade

  validates :book_charge_in_cents, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
