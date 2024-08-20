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
      answer = Answer.find_by(id: params[:id])
      if answer
        render json: answer.as_json(include: [:comments, :votes]), status: :ok
      else
        render json: { errors: ["Answer not found"] }, status: :not_found
      end
    end
  
    # Update an answer
    def update
      answer = Answer.find_by(id: params[:id])
      if answer&.update(answer_params)
        render json: answer, status: :ok
      else
        render json: { errors: answer&.errors&.full_messages || ["Answer not found"] }, status: :bad_request
      end
    end
  
    # Delete an answer
    def destroy
      answer = Answer.find_by(id: params[:id])
      if answer
        answer.destroy
        head :no_content
      else
        render json: { errors: ["Answer not found"] }, status: :not_found
      end
    end
  
    private
  
    def answer_params
      params.require(:answer).permit(:content, :question_id, :user_id)
    end
end
  
