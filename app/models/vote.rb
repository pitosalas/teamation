class Vote < ApplicationRecord
  belongs_to :course
  validate :first_and_second_not_equal
  validate :first_and_third_not_equal
  validate :second_and_third_not_equal
  scope :with_course, -> (course_id) {where(course_id: course_id)}
  scope :with_project_as_first, -> (project_id) { where(vote_first: project_id) }
  scope :with_project_as_second, -> (project_id) { where(vote_second: project_id) }
  scope :with_project_as_third, -> (project_id) { where(vote_third: project_id) }

  def self.vote_exist? student_id, course_id
    Vote.where(student_id: student_id, course_id: course_id).first.present?
  end

  def first_and_second_not_equal
    errors.add(:vote_first, :not_unique, message: "choice can't be the same as second choice") if (vote_first != -1 && vote_second != -1) && (vote_first == vote_second)
  end

  def first_and_third_not_equal
    errors.add(:vote_third, :not_unique, message: "choice can't be the same as first choice") if (vote_first != -1 && vote_third != -1) && (vote_first == vote_third)
  end

  def second_and_third_not_equal
    errors.add(:vote_second, :not_unique, message: "choice can't be the same as third choice") if (vote_second != -1 && vote_third != -1) && (vote_third == vote_second)
  end
end
