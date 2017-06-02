class Corpse < ApplicationRecord
  has_many :lines
  belongs_to :style
  has_many :users, through: :lines, source: :auth
  accepts_nested_attributes_for :lines
end
