json.array!(@examples) do |example|
  json.extract! example, :id, :description, :filename, :line_number, :status, :test_run_id
  json.url example_url(example, format: :json)
end
