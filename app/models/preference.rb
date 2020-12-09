class Preference < ApplicationRecord
    belongs_to :course
    belongs_to :student
    before_validation :remove_empty_dream_partner
    LEVELS = (1..5).to_a.freeze
    TIME_SLOT = ['mondayM', 'mondayA', 'mondayE', 'tuesdayM', 'tuesdayA', 'tuesdayE', 'wednesdayM', 'wednesdayA', 'wednesdayE', 'thursdayM',
                 'thursdayA', 'thursdayE', 'fridayM', 'fridayA', 'fridayE', 'saturdayM', 'saturdayA', 'saturdayE', 'sundayM', 'sundayA', 'sundayE']
    def remove_empty_dream_partner
        dream_partner.reject! { |p| p.nil? }
    end
end
