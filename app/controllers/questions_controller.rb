class QuestionsController < ApplicationController
    # Create a new question
    def create
      question = Question.new(question_params)
      if question.save
        render json: question, status: :created
      else
        render json: { errors: question.errors.full_messages }, status: :bad_request
      end
    end
  
    # Get a specific question by ID
    def show
      question = Question.find_by(id: params[:id])
      if question
        render json: question.as_json(include: [:answers, :comments, :tags, :votes]), status: :ok
      else
        render json: { errors: ["Question not found"] }, status: :not_found
      end
    end
  
    # Update a question
    def update
      question = Question.find_by(id: params[:id])
      if question&.update(question_params)
        render json: question, status: :ok
      else
        render json: { errors: question&.errors&.full_messages || ["Question not found"] }, status: :bad_request
      end
    end
  
    # Delete a question
    def destroy
      question = Question.find_by(id: params[:id])
      if question
        question.destroy
        head :no_content
      else
        render json: { errors: ["Question not found"] }, status: :not_found
      end
    end
  
    # Search questions by keyword and tags
    def search
      questions = Question.all
      questions = questions.where("title ILIKE ? OR content ILIKE ?", "%#{params[:keywords]}%", "%#{params[:keywords]}%") if params[:keywords]
      questions = questions.joins(:tags).where(tags: { id: params[:tag_ids] }) if params[:tag_ids]
      render json: questions, status: :ok
    end
  
    private
  
    def question_params
      params.require(:question).permit(:title, :content, :user_id, tag_ids: [])
    end
end
  
