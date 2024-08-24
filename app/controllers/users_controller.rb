class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create ]
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
    user = User.find(params[:id])
    render json: user, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: [ "User not found" ] }, status: :not_found
  end

  # List all questions posted by a user
  def user_questions
    user = User.find(params[:id])
    render json: user.questions, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: [ "User not found" ] }, status: :not_found
  end

  # List all answers posted by a user
  def user_answers
    user = User.find(params[:id])
    render json: user.answers, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: [ "User not found" ] }, status: :not_found
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
