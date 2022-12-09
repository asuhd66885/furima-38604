class Address < ApplicationRecord
  belongs_to :item
  belongs_to :prefecture
end
