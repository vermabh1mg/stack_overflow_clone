Rails.application.routes.draw do
  resources :users, only: [ :create, :show ] do
    member do
      get "user_questions"
      get "user_answers"
    end
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

  resources :comments, only: [ :create, :show, :update, :destroy ]
  resources :tags, only: [ :index, :create, :update, :destroy ]

  resources :votes, only: [] do
    collection do
      post "questions/:question_id", to: "votes#vote_on_question"
      post "answers/:answer_id", to: "votes#vote_on_answer"
    end
  end
end
