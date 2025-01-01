require "test_helper"

class LibraryBookCheckoutTest < ActiveSupport::TestCase
  test "valid library book checkout can be saved" do
    valid_library_book_checkout = random_library_book_checkout
    assert valid_library_book_checkout.save
  end

  test "invalid if no checked out date" do
    library_book_checkout_without_checked_out_date = random_library_book_checkout
    library_book_checkout_without_checked_out_date.checked_out_date = nil
    assert_not library_book_checkout_without_checked_out_date.valid?
  end

  test "valid if no return date" do
    library_book_checkout_without_return_date = random_library_book_checkout
    library_book_checkout_without_return_date.return_date = nil
    assert library_book_checkout_without_return_date.valid?
  end

  test "invalid if the return date is before the checked out date" do
    library_book_checkout = random_library_book_checkout
    library_book_checkout.return_date = library_book_checkout.checked_out_date - 1.day
    assert_not library_book_checkout.valid?
  end

  test "valid if the return date is the same as the checked out date" do
    library_book_checkout = random_library_book_checkout
    library_book_checkout.return_date = library_book_checkout.checked_out_date
    assert library_book_checkout.valid?
  end

  test "belongs to a library book" do
    assert_equal library_books(:one), library_book_checkouts(:one).library_book
  end

  test "invalid if no library book" do
    library_book_checkout_without_library_book = random_library_book_checkout
    assert library_book_checkout_without_library_book.valid?
    library_book_checkout_without_library_book.library_book = nil
    assert_not library_book_checkout_without_library_book.valid?
  end

  test "invalid if the library book does not exist" do
    library_book_checkout_without_library_book = random_library_book_checkout
    assert library_book_checkout_without_library_book.valid?
    library_book_checkout_without_library_book.library_book_id = 1000 # pointing to a library book id not in the fixtures
    assert_not library_book_checkout_without_library_book.valid?
  end

  test "belongs to a checked out by person" do
    assert_equal people(:jane), library_book_checkouts(:one).checked_out_by
  end

  test "invalid if no checked out by person" do
    library_book_checkout_without_checked_out_by = random_library_book_checkout
    assert library_book_checkout_without_checked_out_by.valid?
    library_book_checkout_without_checked_out_by.checked_out_by = nil
    assert_not library_book_checkout_without_checked_out_by.valid?
  end

  test "invalid if the checked out by person does not exist" do
    library_book_checkout_without_checked_out_by = random_library_book_checkout
    assert library_book_checkout_without_checked_out_by.valid?
    library_book_checkout_without_checked_out_by.checked_out_by_id = 1000 # pointing to a person id not in the fixtures
    assert_not library_book_checkout_without_checked_out_by.valid?
  end

  private
  def random_library_book_checkout
    LibraryBookCheckout.new(library_book: library_books(:one),
                            checked_out_by: people(:jane),
                            checked_out_date: Date.today - 1.week)
  end
end
