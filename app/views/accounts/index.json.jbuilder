json.array!(@accounts) do |account|
  json.extract! account, :id, :name, :description, :amount, :currency, :is_disabled
  json.url account_url(account, format: :json)
end
