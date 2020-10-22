class Preference < ApplicationRecord
    belongs_to :course
    belongs_to :student
    LEVELS = (1..5).to_a.freeze
    TIME_ZONE = ['UTC+12', 'UTC+11', 'UTC+10', 'UTC+9', 'UTC+8', 'UTC+7', 'UTC+6', 'UTC+5', 'UTC+4', 'UTC+3', 'UTC+2', 'UTC+1', 'UTC+0', 
                 'UTC-12', 'UTC-11', 'UTC-10', 'UTC-9', 'UTC-8', 'UTC-7', 'UTC-6', 'UTC-5', 'UTC-4', 'UTC-3', 'UTC-2', 'UTC-1']
    TIME_SLOT = ['mondayD', 'mondayN', 'tuesdayD', 'tuesdayN']
end
