class Person < ApplicationRecord
  GENDER_FEMALE = "F"
  GENDER_MALE = "M"
  GENDER_OTHER = "OTHER"
  GENDERS = [ GENDER_FEMALE, GENDER_MALE, GENDER_OTHER ]
  AVAILABLE_NATIVE_LANGUAGE = %w[Mandarin English Cantonese Other]

  belongs_to :address, optional: true
  has_many :instructor_assignments, foreign_key: "instructor_id"

  validates :english_first_name, :english_last_name, presence: true
  validates :gender, inclusion: { in: GENDERS }
end
