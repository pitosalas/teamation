class StudentsController < ApplicationController
    def show
        puts "#{params[:id]}"
        @user = User.find(params[:id])
    end
end
