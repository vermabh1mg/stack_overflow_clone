class UsersController < ApplicationController
    # Create a new user
    def create
      user = User.new(user_params)
      if user.save
        render json: user, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :bad_request
      end
    end
  
    # Get a specific user by ID
    def show
      user = User.find_by(id: params[:id])
      if user
        render json: user, status: :ok
      else
        render json: { errors: ["User not found"] }, status: :not_found
      end
    end
  
    # List all questions posted by a user
    def user_questions
      user = User.find_by(id: params[:id])
      if user
        questions = user.questions
        render json: questions, status: :ok
      else
        render json: { errors: ["User not found"] }, status: :not_found
      end
    end
  
    # List all answers posted by a user
    def user_answers
      user = User.find_by(id: params[:id])
      if user
        answers = user.answers
        render json: answers, status: :ok
      else
        render json: { errors: ["User not found"] }, status: :not_found
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:username)
    end
end
