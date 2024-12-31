class Person < ApplicationRecord
  GENDER_FEMALE = "F"
  GENDER_MALE = "M"
  GENDERS = [ GENDER_FEMALE, GENDER_MALE ]
  AVAILABLE_NATIVE_LANGUAGE = %w[Mandarin English Cantonese Other]

  belongs_to :address, optional: true

  validates :english_first_name, :english_last_name, presence: true
  validates :gender, inclusion: { in: GENDERS }
end
