json.array!(@movements) do |movement|
  json.extract! movement, :id, :account_id, :mtype_id, :name, :description, :amount, :mdate, :vdate, :account_amount, :is_transfer, :movement_id
  json.url movement_url(movement, format: :json)
end
