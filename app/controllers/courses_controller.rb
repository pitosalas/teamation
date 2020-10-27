class CoursesController < ApplicationController
  before_action :set_course, only: [ :destroy]
  # before_action :authenticate_user!
  # before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])
    if current_user.type == 'Professor'
      current_user.current_course_id = @course.id
      current_user.save
    end
    if Preference.find_by(student_id: current_user.id, course_id: @course.id).nil?
      @preference = @course.preferences.build
    else
      @preference = @course.preferences.find_by(course_id:params[:id])
    end
  end

  # GET /courses/new
  def new
    @course = Course.new
    # respond_to do |format|
    #   format.js {render layout: false}
    # end
  end

  # GET /courses/:id/fill_question
  def fill_question
    @course = Course.find(params[:id])
    # puts params[:withProject] == "true"
    # puts params[:withProject].class
    # if params[:has_project] == "true"
    #   puts "set course has project"
    #   @course.withProject = true
    #   @course.save!
    #   puts @course.withProject
    # end
    # @course.withProject
    # if @course.withProject == true
    #   @course.state = 'project_brainstorm'
    #   @course.save!
    # else
    #   @course.state = 'choose_algo'
    #   @course.save!
    # end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def project_brainstorm
    @course = Course.find(params[:id])
  end

  def project_voting
    @course ||= Course.find(params[:id])
    @current_user_vote = @course.votes.where(student_id: current_user.id).first.nil? ? nil : @course.votes.where(student_id: current_user.id).first
    @course.state = 'project_voting'
    @course.save
  end

  def grouping
    @course = Course.find(params[:id])
    @course.state = 'choose_algo'
    @course.save
  end
  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    @course.pin = (SecureRandom.random_number(9e5) + 1e5).to_i
    @course.professor_id = current_user.id
    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    @course = Course.find_by_id(params[:id])
    respond_to do |format|
      if @course.update(course_params)
          if @course.withProject && !@course.minimum_group_member.nil?
            format.html { redirect_to project_brainstorm_course_path, notice: 'Form Submitted'}
            format.json { render :show, status: :ok, location: @course }
          elsif @course.withProject
            format.html { redirect_to fill_question_course_path(@course), notice: 'Form Submitted'}
            format.json { render :show, status: :ok, location: @course }
          else
            format.html { redirect_to project_brainstorm_course_path(@course), notice: 'Form Submitted'}
            format.json { render :show, status: :ok, location: @course }
          end
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

      # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:id, :name, :pin, :professor_id, :withProject, :maximum_group_member, :minimum_group_member, :has_group, :is_voting, projects_attributes:[:project_name, :course_id, :description, :is_active, :number_of_likes], votes_attributes:[:student_id, :course_id, :vote_first, :vote_second, :vote_third])
      # params.permit(:id, :name, :pin, :professor_id, :has_project, :maximum_group_member, :minimum_group_member, :has_group, :is_voting)
    end
end
