json.extract! tcomment, :id, :content, :user_id, :task_id, :created_at, :updated_at
json.url tcomment_url(tcomment, format: :json)
