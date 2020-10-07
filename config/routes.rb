Rails.application.routes.draw do

  devise_for :students, path: 'students', controllers: {
    registrations: "students/registrations",
    sessions: "students/sessions"
  }
  devise_for :professors, path: 'professors', controllers: {
    registrations: "professors/registrations",
    sessions: "professors/sessions"
  }
  resources :takings
  resources :votes
  resources :preferences
  resources :groups
  resources :courses do
    member do
      get "fill_question"
      get "project_brainstorm"
    end
    resources :projects
  end

  resources :students
  resources :professors
  get 'pages/home'

  root 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
