class Tag < ApplicationRecord
    has_many :tags_questions
    has_many :questions, through: :tags_questions
end
