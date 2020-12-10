class ProfessorsController < ApplicationController
    before_action :authenticate_professor!

    def index
        @users = Professor.all
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        respond_to do |format|
            if @user.update(professor_params)
                sign_in(@user)
                format.html { redirect_to professor_path(@user), notice: 'Professor was successfully updated.' }
                format.json { render :show, status: :ok, location: @user }
            else
                format.html { render :edit }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    # GET /professors/1
    # GET /professors/1.json
    def show
        @user = User.find(params[:id])
        @courses = @user.courses.order('created_at ASC')
    end

    #GET /professors/1/add_course
    def add_course
        @user = User.find(params[:id])
        @professor_id = params[:id]
    end

    #POST /professors/1/create_course
    def create_course
        course_pin = (SecureRandom.random_number(9e5) + 1e5).to_i
        @course = Course.create(name: params[:name], pin: course_pin, professor_id: current_user.id)
        redirect_to :controller => 'professors', :action => 'show', :id => params[:id]
    end

    protected
    def professor_params
        params.require(:professor).permit(:firstname, :lastname, :email, :password, :password_confirmation, :time_zone)
    end
end
