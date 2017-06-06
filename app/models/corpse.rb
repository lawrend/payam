class Corpse < ApplicationRecord
  has_many :lines, dependent: :destroy
  belongs_to :style
  has_many :users, through: :lines, source: :auth
  accepts_nested_attributes_for :lines
  validates :style_id, presence: true
  validates :title, presence: true
  validates_with TitleValidator


  def previous_five
    newln = Line.where(:corpse_id => self.id, :count => self.counter-1).first
    lstln = newln.text
    llstln = lstln.split
    llstln[-6..-1].join(" ")
  end

  def send_to_next
    self.counter += 1
    self.save
  end

  private

end
