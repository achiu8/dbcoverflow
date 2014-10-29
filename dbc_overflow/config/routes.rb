Rails.application.routes.draw do
  get 'answers/index'

  root 'questions#index'

  resources :questions do
    member do
      patch 'upvote'
      patch 'downvote'
    end

    resources :answers do
      member do
        patch 'upvote'
        patch 'downvote'
      end
    end
  end
end
