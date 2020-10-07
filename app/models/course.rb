class Course < ApplicationRecord
    belongs_to :professor
    has_many :takings
    has_many :students, through: :takings
end
