json.extract! project, :id, :name, :description, :web_link, :github_link, :created_at, :updated_at
json.url project_url(project, format: :json)
