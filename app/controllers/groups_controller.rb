class GroupsController < ApplicationController
  # before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :set_course
  include GroupsHelper

  # GET /groups
  # GET /groups.json
  def index
    enough_projects = (@course.students.size / @course.maximum_group_member).ceil
    if @course.students.size <= 0 && @course.groups.size.zero?
      respond_to do |format|
        format.html { redirect_to grouping_course_path(@course), notice: "Your course has no students enrolled yet"}
      end
    elsif @course.projects.active.size < enough_projects && @course.groups.size.zero?
      respond_to do |format|
        format.html { redirect_to grouping_course_path(@course), notice: "You need at least #{enough_projects} active projects to divide students into groups"}
      end
    elsif @course.groups.size.zero?
      if params[:algo] == "preference_only" && !(students_fill_preference_form? @course)
        respond_to do |format|
          format.html { redirect_to grouping_course_path(@course), notice: "All Students need to fill out their preference forms"}
        end
      elsif params[:algo] == "project_only" && !(students_all_vote? @course)
        respond_to do |format|
          format.html { redirect_to grouping_course_path(@course), notice: "All Students need to have first, second, third choices vote"}
        end
      elsif params[:algo] == "holistic" && (!(students_fill_preference_form? @course) || !(students_all_vote? @course))
        respond_to do |format|
          format.html { redirect_to grouping_course_path(@course), notice: "All Students need to have first, second, third choices vote and fill out their prerference forms"}
        end
      else
        if params[:algo].nil?
          respond_to do |format|
            format.html { redirect_to grouping_course_path(@course), notice: "This course has no groups yet"}
          end
        else
          group_service = GroupCreationManager::GroupMatcher.new
          group_service.determine_algo_and_match(@course, params)
          @course.update(has_group: true)
        end
      end
    end
    if @course.groups.size.zero? && @course.state != "view_groups"
      @course.update(state: "view_groups")
    end
    @groups = @course.groups
    @group ||= @course.groups.first
    if current_user.type == 'Professor'
      current_user.current_course_id = @course.id
      current_user.save
    end
    respond_to do |format|
      format.html
      format.csv { send_data @groups.to_csv, filename: "groups-#{Date.today}.csv"}
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = @course.groups.find(params[:id])
  end

  # GET /groups/new
  def new
    @group = Course.groups.build
  end

  # GET /groups/1/edit
  def edit
    @group = Course.groups.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Course.groups.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    @group = Course.groups.new(group_params)
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = @course.groups.find(params[:id])
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # DELETE /groups
  # DELETE /groups
  def destroy_all
    @course.groups.each(&:destroy)
    @course.update(has_group: false, state: "choose_algo")
    respond_to do |format|
      format.html { redirect_to grouping_course_path(@course) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  #
    def set_course
      @course = Course.find(params[:course_id])
    end

    # def set_group
    #   @group = Group.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:course_id, :project_id, :group_name, :students_id)
    end
end
