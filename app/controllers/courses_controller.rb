class CoursesController < ApplicationController
  # before_action :set_course
  before_action :authenticate_user!
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  # before_action :set_course, only: [ :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])
    puts @course.name
    puts @course.file.nil?
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

  def parse_file
      @course = Course.find(params[:id])
      file_path = params[:course][:file].path
      puts file_path
      CSV.foreach(file_path, :headers => true, encoding: 'iso-8859-1:utf-8') do |row|
        row_hash = row.to_h
        if !Project.find_by(project_name: row_hash["Project_Name"], course_id: @course.id).nil?
          time = Time.now
          project_name = row_hash["Project_Name"] + "_" + time.strftime("%Y%m%d%H%M%S")
          Project.create(project_name: project_name, course_id: @course.id, description: row_hash["Description"], is_active: true)
        else
          Project.create(project_name: row_hash["Project_Name"], course_id: @course.id, description: row_hash["Description"], is_active: true)
        end
      end
      redirect_back(fallback_location: project_brainstorm_course_path(@course.id))
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
    if current_user.type == 'Professor'
      current_user.current_course_id = @course.id
      current_user.save
    end
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
    @course.state = 'project_brainstorm'
    @course.save
    if current_user.type == 'Professor'
      current_user.current_course_id = @course.id
      current_user.save
    end
  end

  def project_voting
    @course ||= Course.find(params[:id])
    @current_user_vote = @course.votes.where(student_id: current_user.id).first.nil? ? nil : @course.votes.where(student_id: current_user.id).first
    @course.state = 'project_voting'
    @course.save
    if current_user.type == 'Professor'
      current_user.current_course_id = @course.id
      current_user.save
    end
  end

  def grouping
    @course = Course.find(params[:id])
    @course.state = 'choose_algo'
    @course.save
    if current_user.type == 'Professor'
      current_user.current_course_id = @course.id
      current_user.save
    end
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
    @course.build_preference_weight unless @course.preference_weight
    respond_to do |format|
      if @course.update(course_params)
          if @course.withProject && !@course.minimum_group_member.nil?
            format.html { redirect_to project_brainstorm_course_path(@course), notice: 'Form Submitted'}
            format.json { render :show, status: :ok, location: @course }
          elsif @course.withProject
            format.html { redirect_to fill_question_course_path(@course), notice: 'Form Submitted'}
            format.json { render :show, status: :ok, location: @course }
          else
            format.html { redirect_to project_brainstorm_course_path(@course), notice: 'Form Submitted'}
            format.json { render :show, status: :ok, location: @course }
          end
      else
        format.html { redirect_to fill_question_course_path(@course) }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    if current_user.current_course_id = @course.id
      current_user.current_course_id = nil
      current_user.save
    end
    if current_user.type == 'Professor'
      respond_to do |format|
        format.html { redirect_to professor_path(current_user), notice: 'Course was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to student_path(current_user), notice: 'Course was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

      # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:id, :name, :pin, :professor_id, :withProject, :maximum_group_member, :minimum_group_member, :has_group, :is_voting, :file, projects_attributes:[:project_name, :course_id, :description, :is_active, :number_of_likes], preference_weight_attributes:[:id, :subject_proficiency, :dream_partner, :time_zone, :schedule], votes_attributes:[:student_id, :course_id, :vote_first, :vote_second, :vote_third])
      # params.permit(:id, :name, :pin, :professor_id, :has_project, :maximum_group_member, :minimum_group_member, :has_group, :is_voting)
    end
end
