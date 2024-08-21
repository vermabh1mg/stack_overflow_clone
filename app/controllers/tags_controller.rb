class TagsController < ApplicationController
  # List all tags
  def index
    tags = Tag.all
    render json: tags, status: :ok
  end

  # Create a new tag
  def create
    tag = Tag.new(tag_params)
    if tag.save
      render json: tag, status: :created
    else
      render json: { errors: tag.errors.full_messages }, status: :bad_request
    end
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
    render json: { message: "Tag deleted" }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: [ "Tag not found" ] }, status: :not_found
  end

  private

  def tag_params
    param! :tag, Hash do |t|
      t.param! :name, String, required: true
    end
  end
end
