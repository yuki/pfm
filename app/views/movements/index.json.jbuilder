json.array!(@movements) do |movement|
  json.extract! movement, :name, :description, :amount, :mtype_id, :account_id, :mdate, :account_amount, :is_transfer, :movement_id
  json.url movement_url(movement, format: :json)
end
