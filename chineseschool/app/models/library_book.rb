class LibraryBook < ApplicationRecord
  LIBRARY_BOOK_TYPE_MIXED = "S/T"
  LIBRARY_BOOK_TYPE_SIMPLIFIED = "S"
  LIBRARY_BOOK_TYPE_TRADITIONAL = "T"
  LIBRARY_BOOK_TYPES = [ LIBRARY_BOOK_TYPE_MIXED, LIBRARY_BOOK_TYPE_SIMPLIFIED, LIBRARY_BOOK_TYPE_TRADITIONAL ]

  validates :title, :publisher, presence: true
  validates :book_type, inclusion: { in: LIBRARY_BOOK_TYPES }
end
