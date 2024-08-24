class VotesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :vote_on_question, :vote_on_answer ]

  # Vote on a question
  def vote_on_question
    vote = Vote.new(vote_params)
    vote.votable = Question.find_by(id: params[:question_id])
    save_vote(vote)
  end

  # Vote on an answer
  def vote_on_answer
    vote = Vote.new(vote_params)
    vote.votable = Answer.find_by(id: params[:answer_id])
    save_vote(vote)
  end

  private

  def save_vote(vote)
    if vote.votable.nil?
      render json: { errors: [ "Votable not found" ] }, status: :not_found
    elsif vote.save
      render json: vote, status: :created
    else
      render json: { errors: vote.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def vote_params
    params.require(:vote).permit(:user_id, :value)
  end
end
