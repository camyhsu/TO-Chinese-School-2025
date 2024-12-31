class Family < ApplicationRecord
  belongs_to :address
  belongs_to :parent_one, class_name: "Person"
  belongs_to :parent_two, class_name: "Person", optional: true
  has_and_belongs_to_many :children, class_name: "Person", join_table: "families_children", association_foreign_key: "child_id"
end
