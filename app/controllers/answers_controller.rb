class AnswersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create, :update, :destroy ]
  # Create a new answer
  def create
    answer = Answer.new(answer_params)
    if answer.save
      render json: answer, status: :created
    else
      render json: { errors: answer.errors.full_messages }, status: :bad_request
    end
  end

  # Get a specific answer by ID
  def show
    answer = Answer.with_deleted.find(params[:id])
    if answer
      render json: answer, status: :ok
    else
      render json: { errors: [ "Answer not found" ] }, status: :not_found
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: [ "Answer not found" ] }, status: :not_found
  end

  # Update an answer
  def update
    answer = Answer.find(params[:id])
    if answer.update(answer_params)
      render json: answer, status: :ok
    else
      render json: { errors: answer.errors.full_messages }, status: :bad_request
    end
  end

  # Delete an answer
  def destroy
    answer = Answer.find(params[:id])
    answer.destroy
    head :no_content
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :question_id, :user_id)
  end
end
