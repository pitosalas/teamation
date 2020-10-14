class StudentsController < ApplicationController
    def show
        @user = User.find(params[:id])
        @courses = @user.courses
    end

    def add_course
        @user = User.find(params[:id])
    end

    def enroll_course
        enrollment = EnrollmentManager::Enroll.new
        enroll_notice = enrollment.enroll_a_course(params[:id], params[:pin])
        redirect_to current_user, notice: enroll_notice
    end

    def drop_course
        drop = EnrollmentManager::Enroll.new
        drop.drop_course(params[:id], params[:course_id])
        respond_to do |format|
            format.html { redirect_to current_user, notice: 'Class was dropped.' }
            format.json { head :no_content }
        end
    end
end
