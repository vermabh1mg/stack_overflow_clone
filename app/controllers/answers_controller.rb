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
    param! :answer, Hash do |a|
      a.param! :content, String, required: true
      a.param! :question_id, Integer, required: true
      a.param! :user_id, Integer, required: true
    end
  end
end
