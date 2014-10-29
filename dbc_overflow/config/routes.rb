Rails.application.routes.draw do
  get 'answers/index'

  root 'questions#index'

  resources :questions do
    resources :answers
  end
end
