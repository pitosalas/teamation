class StudentsController < ApplicationController  
    before_action :authenticate_student!

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        respond_to do |format|
            if @user.update(student_params)
                sign_in(@user)
                format.html { redirect_to student_path(@user), notice: 'Student was successfully updated.' }
                format.json { render :show, status: :ok, location: @user }
            else
                format.html { render :edit }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def show
        puts current_user.nil?
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
    
    protected
    def student_params
        params.require(:student).permit(:firstname, :lastname, :email, :password, :password_confirmation)
    end
end
