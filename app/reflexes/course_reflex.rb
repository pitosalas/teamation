# frozen_string_literal: true

class CourseReflex < ApplicationReflex
  before_reflex do
    @course = Course.find(element.dataset[:course_id])
    @project = Project.find(element.dataset[:project_id])
    @user = Professor.find(element.dataset[:user_id])
    # @course.assign_attributes(course_params)
  end

  def voteFirst
    vote("first")
  end

  def voteSecond
    vote("second")
  end

  def voteThird
    vote("third")
  end

  def vote preference
    vote_p = "vote_third"
    if preference == "first"
      vote_p = "vote_first"
    end
    if preference == "second"
      vote_p = "vote_second"
    end
    # @vote = nil
    if Vote.vote_exist?(@user.id, @course.id)
      @vote = @course.votes.find_by_student_id(@user.id)
      @vote.update("#{vote_p}": @project.id)
      @vote.valid?
      @vote.errors.full_messages.each do |e|
        @course.errors.add(:votes, e)
      end
      # puts "vote errors"
      # @course.save!
      # # @course.save
      # puts @course.errors.count
    else
      @vote = @course.votes.create!(student_id: @user.id, course_id: @course.id, "#{vote_p}": @project.id)
      # @vote.save
      # @vote.validate
      # @course.validate
    end
  end

  def unvoteFirst
    @vote = Vote.where(student_id: @user.id, course_id: @course.id)
    @vote.update(vote_first: -1)
  end

  def unvoteSecond
    @vote = Vote.where(student_id: @user.id, course_id: @course.id)
    @vote.update(vote_second: -1)
  end

  def unvoteThird
    @vote = Vote.where(student_id: @user.id, course_id: @course.id)
    @vote.update(vote_third: -1)
  end

  private

    def course_params
      params.require(:course).permit(:id, :course_id, :project_id, :user_id, :name, :pin, :professor_id, :has_project, :maximum_group_member, :minimum_group_member, :has_group, :is_voting, projects_attributes:[:project_name, :course_id, :description, :is_active, :number_of_likes], votes_attributes:[:student_id, :course_id, :vote_first, :vote_second, :vote_third])
    end

  # def repeat_vote? preference
  #   if preference == "vote_first"
  #     @vote.vote_first == @project.id
  #   elsif preference == "vote_second"
  #     @vote.vote_second == @project.id
  #   elsif preference == "vote_third"
  #     @vote.vote_third == @project.id
  #   end
  # end

  # Add Reflex methods in this file.
  #
  # All Reflex instances expose the following properties:
  #
  #   - connection - the ActiåonCable connection
  #   - channel - the ActionCable channel
  #   - request - an ActionDispatch::Request proxy for the socket connection
  #   - session - the ActionDispatch::Session store for the current visitor
  #   - url - the URL of the page that triggered the reflex
  #   - element - a Hash like object that represents the HTML element that triggered the reflex
  #   - params - parameters from the element's closest form (if any)
  #
  # Example:
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com

end
