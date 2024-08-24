class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  has_many :tags_questions
  has_many :tags, through: :tags_questions
end
