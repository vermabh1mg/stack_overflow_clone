class TagsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create, :update, :destroy ]

  # Create a new tag
  def create
    tag = Tag.create!(tag_params)
    render json: tag, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { errors: [ e.message ] }, status: :unprocessable_entity
  end

  # Update a tag
  def update
    tag = Tag.find(params[:id])
    if tag.update(tag_params)
      render json: tag, status: :ok
    else
      render json: { errors: tag.errors.full_messages }, status: :bad_request
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: [ "Tag not found" ] }, status: :not_found
  end

  # Delete a tag
  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { errors: [ "Tag not found" ] }, status: :not_found
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
