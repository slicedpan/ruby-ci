json.array!(@github_accounts) do |github_account|
  json.extract! github_account, :id, :name, :client_id, :client_secret, :url
  json.url github_account_url(github_account, format: :json)
end
