Rails.application.routes.draw do
  resources :character_quizzes
  resources :quizzes
  resources :characters
  resources :character_languages
  resources :languages
  resources :characters do
    member do
      post :add_languages
    end
  end
  devise_for :users
  root "pages#home"
end
