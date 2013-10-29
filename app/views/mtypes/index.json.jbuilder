json.array!(@mtypes) do |mtype|
  json.extract! mtype, :name
  json.url mtype_url(mtype, format: :json)
end
