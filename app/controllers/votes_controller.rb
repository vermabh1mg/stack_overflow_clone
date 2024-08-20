class VotesController < ApplicationController
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
      if vote.save
        render json: vote, status: :created
      else
        render json: { errors: vote.errors.full_messages }, status: :bad_request
      end
    end
  
    def vote_params
      params.require(:vote).permit(:user_id, :value)
    end
end
  
