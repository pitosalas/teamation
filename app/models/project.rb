class Project < ApplicationRecord
  belongs_to :course
  scope :active, -> { where(is_active: true) }
  scope :onhold, -> { where(is_active: false) }

end
