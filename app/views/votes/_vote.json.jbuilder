json.extract! vote, :id, :student_id, :course_id, :vote_first, :vote_second, :vote_third, :created_at, :updated_at
json.url vote_url(vote, format: :json)
