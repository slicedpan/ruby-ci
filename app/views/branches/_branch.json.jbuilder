json.extract! branch, :id, :name  
json.url branch_url(branch, format: :json)
json.test_runs do
  json.array!(branch.test_runs.order(:updated_at).reverse_order.limit(5)) do |test_run|
    json.extract! test_run, :id, :status
    json.date_completed test_run.updated_at
  end
end