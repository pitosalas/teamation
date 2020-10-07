class ProfessorsController < ApplicationController
    # GET /professors/1
    # GET /professors/1.json
    def show
        @user = User.find(params[:id])
        @courses = @user.courses
    end

    def edit
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
end
