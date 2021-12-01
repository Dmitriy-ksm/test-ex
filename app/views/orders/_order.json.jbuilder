json.(order, :amount, :id)
json.positions order.orders_descriptions do |position|
  unless position.item.nil?
    json.extract! position.item, :name, :price, :id
  end
  json.quantity position.quantity
  json.id position.id
end