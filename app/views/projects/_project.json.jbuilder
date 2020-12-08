json.extract! project, :id, :project_name, :course_id, :description, :is_active, :number_of_likes, :created_at, :updated_at
json.url project_url(project, format: :json)
