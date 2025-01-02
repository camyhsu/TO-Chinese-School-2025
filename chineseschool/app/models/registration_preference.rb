class RegistrationPreference < ApplicationRecord
  belongs_to :student, class_name: "Person"
  belongs_to :entered_by, class_name: "Person"
  belongs_to :grade
  belongs_to :previous_grade, class_name: "Grade", optional: true
end
