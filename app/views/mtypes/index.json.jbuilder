json.array!(@mtypes) do |mtype|
  json.extract! mtype, :id, :name
  json.url mtype_url(mtype, format: :json)
end
