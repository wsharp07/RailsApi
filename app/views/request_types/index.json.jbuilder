json.array!(@request_types) do |request_type|
  json.extract! request_type, :id
  json.url request_type_url(request_type, format: :json)
end
