Rails.application.routes.draw do

  resources :takings
  resources :votes
  resources :preferences
  resources :projects
  resources :groups
  resources :courses
  devise_for :students, path: 'students', controllers: {
    registrations: "students/registrations",
    sessions: "students/sessions"
  }
  devise_for :professors, path: 'professors', controllers: {
    registrations: "professors/registrations",
    sessions: "professors/sessions"
  }

  resources :students
  resources :professors
  get 'pages/home'

  root 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
