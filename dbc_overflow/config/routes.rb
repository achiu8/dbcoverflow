Rails.application.routes.draw do
  get 'answers/index'

  root 'questions#index'

  resources :questions do
    resources :answers
  end

  patch 'questions/:id/up_vote' => 'questions#up_vote'
  patch 'questions/:id/down_vote' => 'questions#down_vote'
end
