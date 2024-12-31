require "test_helper"

class LibraryBookTest < ActiveSupport::TestCase
  test "valid library book can be saved" do
    valid_library_book = random_library_book
    assert valid_library_book.save
  end

  test "invalid if no title" do
    library_book_without_title = random_library_book
    library_book_without_title.title = " "
    assert_not library_book_without_title.valid?
  end

  test "invalid if no publisher" do
    library_book_without_publisher = random_library_book
    library_book_without_publisher.publisher = " "
    assert_not library_book_without_publisher.valid?
  end

  test "invalid if book type is not one of the valid values" do
    library_book_without_valid_book_type = random_library_book
    library_book_without_valid_book_type.book_type = nil
    assert_not library_book_without_valid_book_type.valid?
    library_book_without_valid_book_type.book_type = "Some Invalid Book Type"
    assert_not library_book_without_valid_book_type.valid?
  end

  private
  def random_library_book
    LibraryBook.new(title: TestRandom.alphanumeric(13),
                    publisher: TestRandom.alphanumeric(23),
                    book_type: LibraryBook::LIBRARY_BOOK_TYPES.sample)
  end
end
