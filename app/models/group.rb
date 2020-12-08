class Group < ApplicationRecord
  belongs_to :course

  def find_group_by_student student_id
    students_id.each do |s_id|
      if s_id == student_id
        return id
      end
    end
    nil
  end

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << ["Pre-assign Room Name", "Email Address"] 
      room_id = 1
      all.each do |group|
        group.students_id.each do |id|
          csv << ["room" + room_id.to_s, User.find(id).email]
        end
        room_id += 1
      end
    end
  end
end
