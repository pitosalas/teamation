Rails.application.routes.draw do

  devise_for :students, path: 'students', controllers: {
    registrations: "students/registrations",
    sessions: "students/sessions",
  
  }
  devise_for :professors, path: 'professors', controllers: {
    registrations: "professors/registrations",
    sessions: "professors/sessions"
  }

  resources :takings
  resources :courses do
    member do
      get "fill_question"
      get "project_brainstorm"
      get "project_voting"
      get "grouping"
    end
    resources :projects
    resources :votes
    resources :groups
    resources :preferences
  end


  resources :students do
    member do 
      get 'add_course'
      post 'enroll_course'
      delete 'drop_course'
    end
  end

  resources :professors do
    member do
      get 'add_course'
      post 'create_course'
    end
  end


  get 'pages/home'

  root 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
