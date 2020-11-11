class Preference < ApplicationRecord
    belongs_to :course
    belongs_to :student
    before_validation :remove_empty_dream_partner
    LEVELS = (1..5).to_a.freeze
    TIME_ZONE = ['UTC+12', 'UTC+11', 'UTC+10', 'UTC+9', 'UTC+8', 'UTC+7', 'UTC+6', 'UTC+5', 'UTC+4', 'UTC+3', 'UTC+2', 'UTC+1', 'UTC+0', 
                 'UTC-12', 'UTC-11', 'UTC-10', 'UTC-9', 'UTC-8', 'UTC-7', 'UTC-6', 'UTC-5', 'UTC-4', 'UTC-3', 'UTC-2', 'UTC-1']
    TIME_SLOT = ['mondayM', 'mondayA', 'mondayE', 'tuesdayM', 'tuesdayA', 'tuesdayE', 'wednesdayM', 'wednesdayA', 'wednesdayE', 'thursdayM',
                 'thursdayA', 'thursdayE', 'fridayM', 'fridayA', 'fridayE', 'saturdayM', 'saturdayA', 'saturdayE', 'sundayM', 'sundayA', 'sundayE']
    def remove_empty_dream_partner
        dream_partner.reject! { |p| p.nil? }
    end
end
