# frozen_string_literal: true

class Professors::SessionsController < Devise::SessionsController
  include ApplicationHelper
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    if professor_signed_in?
      if current_professor.current_course_id.nil?
        redirect_to professor_path(current_professor)
      else
        current_course = Course.find_by(id: current_professor.current_course_id)
        if has_project? current_course
          if at_fill_question? current_course
            redirect_to fill_question_course_path(current_course.id)
          elsif at_project_brainstorm? current_course
            redirect_to project_brainstorm_course_path(current_course.id)
          elsif at_project_voting? current_course
            redirect_to project_voting_course_path(current_course.id)
          elsif at_choose_algo? current_course
            redirect_to grouping_course_path(current_course.id)
          elsif at_view_groups? current_course
            redirect_to course_groups_path(current_course.id)
          else
            redirect_to course_path(current_course.id)
          end
        else
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
