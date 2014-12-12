json.array!(@repos) do |repo|
  json.extract! repo, :id, :name, :github_account_id, :github_name, :last_synced
  json.url repo_url(repo, format: :json)
end
