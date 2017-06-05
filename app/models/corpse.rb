class Corpse < ApplicationRecord
  has_many :lines, dependent: :destroy
  belongs_to :style
  has_many :users, through: :lines, source: :auth
  accepts_nested_attributes_for :lines

  def previous_five
    newln = Line.where(:corpse_id => self.id, :count => self.counter-1).first
    lstln = newln.text
    llstln = lstln.split
    llstln[-6..-1].join(" ")
  end

end
