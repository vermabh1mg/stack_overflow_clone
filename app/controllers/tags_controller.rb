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
      tag = Tag.find_by(id: params[:id])
      if tag&.update(tag_params)
        render json: tag, status: :ok
      else
        render json: { errors: tag&.errors&.full_messages || ["Tag not found"] }, status: :bad_request
      end
    end
  
    # Delete a tag
    def destroy
      tag = Tag.find_by(id: params[:id])
      if tag
        tag.destroy
        head :no_content
      else
        render json: { errors: ["Tag not found"] }, status: :not_found
      end
    end
  
    private
  
    def tag_params
      params.require(:tag).permit(:name)
    end
end
  
