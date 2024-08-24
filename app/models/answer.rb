class Answer < ApplicationRecord
  acts_as_paranoid

  belongs_to :question
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  validates :content, presence: true
  validates :question_id, presence: true
  validates :user_id, presence: true
end
