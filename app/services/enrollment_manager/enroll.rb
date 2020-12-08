module EnrollmentManager

    class Enroll
        def enroll_a_course(student_id, course_pin)
            course = Course.find_by(pin: course_pin)
            if course.nil?
                return "The course pin is not correct. Please try again."
            end

            if Taking.where(student_id: student_id, course_id: course.id).size > 0
                return "You have already enrolled in this course."
            end

            Taking.create(student_id: student_id, course_id: course.id)
            return "Course enrolled!"
        end

        def drop_course(student_id, course_id)
            Taking.where(student_id: student_id, course_id: course_id).delete_all
            Preference.where(student_id: student_id, course_id: course_id).delete_all
        end
    end
end