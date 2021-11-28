json.(order, :amount, :id)
json.positions order.orders_descriptions do |position|
  json.extract! position.item, :name, :price
  json.quantity position.quantity
  json.id position.id
end