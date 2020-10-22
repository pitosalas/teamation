class VotesController < ApplicationController
  # before_action :set_vote, only: [:show, :edit, :update, :destroy]
  before_action :set_course

  # GET /votes
  # GET /votes.json
  def index
    @votes = @course.votes
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
    @vote = @course.votes.find(params[:id])
  end

  # GET /votes/new
  def new
    @vote = @course.votes.build
  end

  # GET /votes/1/edit
  def edit
    @vote = @course.votes.find(params[:id])
  end

  # POST /votes
  # POST /votes.json
  def create
    @vote = @course.votes.new(vote_params)
    respond_to do |format|
      if @vote.save
        format.html { redirect_to @vote, notice: 'Vote was successfully created.' }
        format.json { render :show, status: :created, location: @vote }
      else
        format.html { render :new }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /votes/1
  # PATCH/PUT /votes/1.json
  def update
    @vote = @course.votes.find(params[:id])
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote = @course.votes.find(params[:id])
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to votes_url, notice: 'Vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:course_id])
    end

    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vote_params
      params.require(:vote).permit(:student_id, :course_id, :vote_first, :vote_second, :vote_third)
    end
end
