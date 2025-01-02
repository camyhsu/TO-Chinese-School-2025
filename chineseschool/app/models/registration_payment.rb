class RegistrationPayment < ApplicationRecord
  belongs_to :paid_by, class_name: "Person"
  has_many :gateway_transactions

  validates :elective_class_due_in_cents, :pva_due_in_cents, :ccca_due_in_cents, :grand_total_in_cents,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
