class ProjectsController < ApplicationController
  # before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_course
  # GET /projects
  # GET /projects.json
  def index
    @projects = @course.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = @course.projects.find(params[:id])
  end

  # GET /projects/new
  def new
    @project = @course.projects.build
  end

  # GET /projects/1/edit
  def edit
    @project = @course.projects.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = @course.projects.new(project_params)
    @project.added_by = current_user.id
    respond_to do |format|
      if @project.save
        format.html { redirect_to project_brainstorm_course_path(@project.course_id) }
        format.html { redirect_to project_brainstorm_course_path(params[:course_id]), notice: 'Project was successfully created.'}
      else
        format.html { redirect_to project_brainstorm_course_path(@project.course_id) }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    @project = @course.projects.find(params[:id])
    if current_user.type == "professor" || @project.added_by = current_user.id
      if @project.update(project_params)
        respond_to do |format|
          format.html { redirect_to project_brainstorm_course_path(@project.course_id), notice: 'Project was successfully updated.'}
        end
      else
        respond_to do |format|
          format.html { redirect_to project_brainstorm_course_path(@project.course_id), notice: 'Project was not updated.'}
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to project_brainstorm_course_path(@project.course_id), notice: 'You cannot edit this project.'}
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = @course.projects.find(params[:id])
    if current_user.type == "professor" || @project.added_by == current_user.id
      @project.destroy
      respond_to do |format|
        format.html { redirect_to project_brainstorm_course_path(@project.course_id), notice: 'Project was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to project_brainstorm_course_path(@project.course_id), notice: 'You cannot delete this project.' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_course
      @course = Course.find(params[:course_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end
    #
    # # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:project_name, :course_id, :description, :is_active, :number_of_likes)
    end
end
