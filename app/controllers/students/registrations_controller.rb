# frozen_string_literal: true

class Students::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @student = Student.new
  end

  # POST /resource
  def create
    @student = Student.new(student_params)
    respond_to do |format|
      if @student.save
        sign_in(@student)
        format.html { redirect_to student_path(@student)}
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /resource/edit
  # def edit
  #   # @student = Student.find(current_student.id)
  # end

  # PUT /resource
  # def update
  #   respond_to do |format|
  #     if @student.update(student_params)
  #       sign_in(@student)
  #       format.html { redirect_to student_path(@student), notice: 'Student was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @student }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @student.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :email, :password, :password_confirmation])
  # end

  def student_params
    params.require(:student).permit(:firstname, :lastname, :email, :password, :password_confirmation)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
