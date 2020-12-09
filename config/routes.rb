Rails.application.routes.draw do

  match 'project_download', to: 'courses#project_download', as: 'download_project_list', via: :get
  match 'student_download', to: 'courses#student_download', as: 'download_student_list', via: :get
  devise_for :students, path: 'students', controllers: {
    registrations: "students/registrations",
    sessions: "students/sessions"
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
      patch "update_mode"
      patch "parse_project_file"
      patch "parse_student_file"    
    end
    
    resources :projects
    resources :votes
    resources :groups do
      collection do
        delete "destroy_all"
      end
    end
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
