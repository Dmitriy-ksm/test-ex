class AddIndexesToItem < ActiveRecord::Migration[6.1]
  def change
    add_index :items, :price
    add_index :items, :name
  end
end
