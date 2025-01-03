class Right < ApplicationRecord
  validates :name, :controller, :action, presence: true
end
