json.array!(@services) do |service|
  json.extract! service, :name
  json.url service_url(service, format: :json)
end
