class PreferencesController < ApplicationController
  before_action :set_course
  before_action :set_preference, only: [:show, :edit, :update, :destroy]

  # GET /preferences
  # GET /preferences.json
  def index
    @preferences = @course.preferences
  end

  # GET /preferences/1
  # GET /preferences/1.json
  def show
    @preference = @course.preferences.find(params[:id])
  end

  # GET /preferences/new
  def new
    @preference = @course.preferences.build
  end

  # GET /preferences/1/edit
  def edit
    @preference = @course.preferences.find(params[:id])
  end

  # POST /preferences
  # POST /preferences.json
  def create
    schedule_arr = []
    Preference::TIME_SLOT.each do |t|
      if !params[t].nil?
        schedule_arr << t
      end
    end
    schedule_j = schedule_arr.to_json
    @preference = @course.preferences.new(preference_params.merge(schedule: schedule_j))
    respond_to do |format|
      if @preference.save
        format.html { redirect_to course_preference_path(@course.id), notice: 'Preference was successfully created.' }
        format.json { render :show, status: :created, location: @preference }
      else
        format.html { render :new }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /preferences/1
  # PATCH/PUT /preferences/1.json
  def update
    @preference = @course.preferences.find(params[:id])
    schedule_arr = []
    Preference::TIME_SLOT.each do |t|
      if !params[t].nil?
        schedule_arr << t
      end
    end
    schedule_j = schedule_arr.to_json
    respond_to do |format|
      if @preference.update(preference_params.merge(schedule: schedule_j))
        format.html { redirect_to course_preference_path(@course.id), notice: 'Preference was successfully updated.' }
        format.json { render :show, status: :ok, location: @preference }
      else
        format.html { render :edit }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preferences/1
  # DELETE /preferences/1.json
  def destroy
    @preference.destroy
    respond_to do |format|
      format.html { redirect_to preferences_url, notice: 'Preference was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      # @course = params[:preference].nil? ? Course.find(params[:course_id]) : Course.find(params[:preference][:course_id])
      @course = Course.find(params[:course_id])
    end

    def set_preference
      @preference = @course.preferences.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def preference_params
      params.require(:preference).permit(:student_id, :course_id, :subject_matter_proficiency, :time_zone, :schedule, dream_partner: [])
    end
end
