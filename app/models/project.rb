class Project < ApplicationRecord
  belongs_to :course
  scope :active, -> { where(is_active: true) }
  scope :onhold, -> { where(is_active: false) }

  # def self.active
  #   Project.where(is_active: true)
  # end
  #
  # def self.onhold
  #   Project.where(is_active: false)
  # end
end
