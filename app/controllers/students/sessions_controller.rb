# frozen_string_literal: true

class Students::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  # end

  # POST /resource/sign_in
  def create
    # redirect_to student_path(current_student)
    if student_signed_in?
      redirect_to student_path(current_student), notice: "Signed In Successfully."
    else
      redirect_to root_path, notice: 'Invalid Login Information Entered.'
    end
    # self.resource = warden.authenticate!(auth_options)
    # set_flash_message(:notice, :signed_in) if is_navigational_format?
    # if sign_in(resource_name, resource)
    #   redirect_to student_path(current_student)
    # else
    #   respond_to do |format|
    #     format.html { redirect_to root_path, notice: 'Class was dropped.' }
    #   end
    # end
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
