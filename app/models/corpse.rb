class Corpse < ApplicationRecord
  has_many :lines
  belongs_to :style
  has_many :users, through: :lines, source: :auth
end
