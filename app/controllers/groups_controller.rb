class GroupsController < ApplicationController
  # before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :set_course

  # GET /groups
  # GET /groups.json
  def index
    @groups ||= @course.groups
    @group ||= @course.groups.first

    respond_to do |format|
      format.html
      format.csv {send_data @groups.to_csv, filename: "groups-#{Date.today}.csv"}
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
