class CommentsController < ApplicationController
    # Add a comment to a question
    def create_for_question
      comment = Comment.new(comment_params)
      comment.commentable = Question.find_by(id: params[:question_id])
      save_comment(comment)
    end
  
    # Add a comment to an answer
    def create_for_answer
      comment = Comment.new(comment_params)
      comment.commentable = Answer.find_by(id: params[:answer_id])
      save_comment(comment)
    end
  
    # Update a comment
    def update
      comment = Comment.find_by(id: params[:id])
      if comment&.update(comment_params)
        render json: comment, status: :ok
      else
        render json: { errors: comment&.errors&.full_messages || ["Comment not found"] }, status: :bad_request
      end
    end
  
    # Delete a comment
    def destroy
      comment = Comment.find_by(id: params[:id])
      if comment
        comment.destroy
        head :no_content
      else
        render json: { errors: ["Comment not found"] }, status: :not_found
      end
    end
  
    private
  
    def save_comment(comment)
      if comment.save
        render json: comment, status: :created
      else
        render json: { errors: comment.errors.full_messages }, status: :bad_request
      end
    end
  
    def comment_params
      params.require(:comment).permit(:content, :user_id)
    end
end
  
