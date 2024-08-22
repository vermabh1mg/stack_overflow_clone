class CommentsController < ApplicationController
  # Create a new comment
  def create
    begin
      comment = Comment.create!(comment_params)
      render json: comment, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.record.errors.full_messages }, status: :bad_request
    end
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
    param! :comment, Hash do |c|
      c.param! :content, String, required: true
      c.param! :commentable_id, Integer, required: true
      c.param! :commentable_type, String, required: true, in: [ "question", "answer" ]
    end
  end
end
