class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create, :update, :destroy ]

  # Create a new comment
  def create
    comment = Comment.create!(comment_params)
    render json: comment, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  # Update a comment
  def update
    comment = Comment.find(params[:id])
    if comment.update(comment_params)
      render json: comment, status: :ok
    else
      render json: { errors: comment.errors.full_messages }, status: :bad_request
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: [ "Comment not found" ] }, status: :not_found
  end

  # Delete a comment
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: { message: "Comment deleted" }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: [ "Comment not found" ] }, status: :not_found
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type, :user_id)
  end
end
