class Course < ApplicationRecord
    belongs_to :professor
    has_many :groups
    has_many :preferences
    has_many :projects, dependent: :destroy
    has_many :takings
    has_many :students, through: :takings
    has_many :groups, -> { order(position: :asc)}, dependent: :destroy
    # def has_enough_projects
    #     return active_groups() >= 3
    # end
end
