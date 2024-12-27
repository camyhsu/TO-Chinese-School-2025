class Address < ApplicationRecord
  validates :city, :email, :state, :street, presence: true
  validates :zipcode, length: { is: 5 }
  validates :zipcode, format: { without: /\D/ }
  validates :home_phone, length: { is: 10 }
  validates :home_phone, format: { without: /\D/ }
  validates :cell_phone, length: { is: 10 }, allow_blank: true
  validates :cell_phone, format: { without: /\D/ }

  before_validation :clean_phone_numbers

  private
  def clean_phone_numbers
    self.home_phone = clean_phone_number home_phone
    self.cell_phone = clean_phone_number cell_phone
  end

  def clean_phone_number(number_to_clean)
    return nil if number_to_clean.nil?
    number_to_clean.gsub /\D/, ""
  end
end