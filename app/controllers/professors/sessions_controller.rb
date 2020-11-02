# frozen_string_literal: true

class Professors::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    if professor_signed_in?
      if current_professor.current_course_id.nil?
        redirect_to professor_path(current_professor), notice: "Signed In Successfully."
      else
        puts "professor sign in"
        current_course = Course.find_by(id: current_professor.current_course_id)
        puts current_course.withProject.nil?
        if current_course.withProject == true
          puts "at current course"
          if current_course.state == "fill_question"
            redirect_to fill_question_course_path(current_course.id)
          elsif current_course.state == "project_brainstorm"
            redirect_to project_brainstorm_course_path(current_course.id)
          elsif current_course.state == "project_voting"
            redirect_to project_voting_course_path(current_course.id)
          elsif current_course.state == "choose_algo"
            puts "at choose algo"
            redirect_to grouping_course_path(current_course.id)
          else
            puts "at course path"
            redirect_to course_path(current_course.id)
          end
        else
          puts "does not has project"
          redirect_to course_path(current_course.id)
        end
      end
    else
      redirect_to root_path, notice: "Invalid Login Information Entered."
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
