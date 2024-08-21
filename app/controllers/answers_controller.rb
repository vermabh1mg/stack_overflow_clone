class AnswersController < ApplicationController
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
    answer = Answer.find(params[:id])
    render json: answer, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ["Answer not found"] }, status: :not_found
  end

  private

  def answer_params
    param! :answer, Hash do |a|
      a.param! :content, String, required: true
      a.param! :question_id, Integer, required: true
      a.param! :user_id, Integer, required: true
    end
  end
end
