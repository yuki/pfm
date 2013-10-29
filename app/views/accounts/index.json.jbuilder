json.array!(@accounts) do |account|
  json.extract! account, :name, :description, :amount, :currency
  json.url account_url(account, format: :json)
end
