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
    question = Question.find(params[:id])
    render json: question, include: [ :answers, :comments, :tags ], status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: [ "Question not found" ] }, status: :not_found
  end

  # Update a question
  def update
    question = Question.find(params[:id])
    if question.update(question_params)
      render json: question, status: :ok
    else
      render json: { errors: question.errors.full_messages }, status: :bad_request
    end
  rescue ActiveRecord::RecordNotFound

    # Delete a question
    def destroy
      question = Question.find(params[:id])
      question.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound
      render json: { errors: [ "Question not found" ] }, status: :not_found
    end
    render json: { errors: [ "Question not found" ] }, status: :not_found
  end

  # Search questions by keyword and tags
  def search
    param! :keywords, String, required: false
    param! :tag_ids, Array, of: Integer, required: false
    questions = Question.includes(:tags).all
    if params[:keywords].present?
      questions = questions.where("title ILIKE :keywords OR content ILIKE :keywords", keywords: "%#{params[:keywords]}%")
    end
    if params[:tag_ids].present?
      questions = questions.joins(:tags).where(tags: { id: params[:tag_ids] })
    end
    render json: questions, status: :ok
  end

  private

  def question_params
    param! :question, Hash do |q|
      q.param! :title, String, required: true
      q.param! :content, String, required: true
      q.param! :user_id, Integer, required: true
    end
  end
end
