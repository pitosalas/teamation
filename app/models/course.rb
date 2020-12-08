class Course < ApplicationRecord
    attr_accessor :has_project
    belongs_to :professor
    has_one_attached :file
    has_many :preferences, dependent: :destroy
    has_many :projects, dependent: :destroy
    accepts_nested_attributes_for :projects
    has_many :votes
    has_many :votes, autosave: true
    has_one :preference_weight, inverse_of: :course
    accepts_nested_attributes_for :preference_weight, update_only: true
    accepts_nested_attributes_for :votes
    validates_associated :preference_weight
    has_many :takings
    has_many :students, through: :takings
    has_many :groups, -> { order(group_name: :asc)}, dependent: :destroy
    # has_many :groups, -> { order(position: :asc)}, dependent: :destroy
    # def has_enough_projects
    #     return active_groups() >= 3
    # end
    #
    # validate do |course|
    #     course.votes.each do |vote|
    #       next if vote.valid?
    #       student.errors.full_messages.each do |msg|
    #           # you can customize the error message here:
    #           errors.add_to_base("Student Error: #{msg}")
    #       end
    #     end
    # end

    def has_enough_project? course
        return course.projects.size >= 3
    end
end
