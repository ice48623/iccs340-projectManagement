json.extract! task_comment, :id, :content, :user_id, :task_id, :created_at, :updated_at
json.url task_comment_url(task_comment, format: :json)
