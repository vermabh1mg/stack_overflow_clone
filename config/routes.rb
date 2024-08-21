Rails.application.routes.draw do
  resources :users, only: [ :create, :show ] do
    get "questions", to: "users#user_questions"
    get "answers", to: "users#user_answers"
  end

  resources :questions do
    collection do
      get "search"
    end
    resources :comments, only: [ :create ], module: :questions
  end

  resources :answers, only: [ :create, :show, :update, :destroy ] do
    resources :comments, only: [ :create ], module: :answers
  end

  resources :comments, only: [ :update, :destroy ]

  resources :tags, only: [ :index, :create, :update, :destroy ]

  resources :votes, only: [] do
    post "questions/:question_id", to: "votes#vote_on_question", on: :collection
    post "answers/:answer_id", to: "votes#vote_on_answer", on: :collection
  end
end
