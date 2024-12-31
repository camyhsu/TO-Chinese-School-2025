class Grade < ApplicationRecord
  belongs_to :next_grade, class_name: "Grade", foreign_key: "next_grade"
  has_one :previous_grade, class_name: "Grade", inverse_of: "next_grade"
end
