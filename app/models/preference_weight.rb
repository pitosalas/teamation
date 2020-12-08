class PreferenceWeight < ApplicationRecord
  belongs_to :course, inverse_of: :preference_weight
  attribute :subject_proficiency, default: 0
  attribute :dream_partner, default: 0
  attribute :schedule, default: 0
  attribute :time_zone, default: 0
  attribute :project_voting, default: 0
  validates :subject_proficiency, presence: true
  validates :dream_partner, presence: true
  validates :schedule, presence: true
  validates :time_zone, presence: true
end
