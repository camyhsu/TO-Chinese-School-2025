class LibraryBookCheckout < ApplicationRecord
  belongs_to :library_book
  belongs_to :checked_out_by, class_name: "Person"

  validates :checked_out_date, presence: true
  validates :return_date, comparison: { greater_than_or_equal_to: :checked_out_date }, allow_nil: true
end
