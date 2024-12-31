class Family < ApplicationRecord
  belongs_to :address
  belongs_to :parent_one, class_name: "Person"
  belongs_to :parent_two, class_name: "Person", optional: true
end
