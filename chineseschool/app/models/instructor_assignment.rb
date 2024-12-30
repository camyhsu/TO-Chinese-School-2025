class InstructorAssignment < ApplicationRecord
  ROLE_PRIMARY_INSTRUCTOR = "Primary Instructor"
  ROLE_ROOM_PARENT = "Room Parent"
  ROLE_SECONDARY_INSTRUCTOR = "Secondary Instructor"
  ROLE_TEACHING_ASSISTANT = "Teaching Assistant"
  ROLES = [ ROLE_PRIMARY_INSTRUCTOR, ROLE_ROOM_PARENT, ROLE_SECONDARY_INSTRUCTOR, ROLE_TEACHING_ASSISTANT ]

  validates :start_date, :end_date, presence: true
  validates :end_date, comparison: { greater_than_or_equal_to: :start_date }
  validates :role, inclusion: { in: ROLES }
end
