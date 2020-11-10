class PreferenceWeight < ApplicationRecord
  belongs_to :course, inverse_of: :preference_weight
  validates :subject_proficiency, presence: true
  validates :dream_partner, presence: true
  validates :schedule, presence: true
  validates :time_zone, presence: true
end
