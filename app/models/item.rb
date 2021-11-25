class Item < ApplicationRecord
    validates :price,  numericality: { greater_than_or_equal_to: 0, allow_nil: true }
    validates :name, presence: true

    has_many :orders_descriptions
    has_many :orders, through: :orders_descriptions

end
