class Corpse < ApplicationRecord
  has_many :lines, dependent: :destroy
  belongs_to :style
  has_many :users, through: :lines, source: :auth
  accepts_nested_attributes_for :lines
  accepts_nested_attributes_for :style, reject_if: proc {|att| att['name'].blank? }
  validates :style, presence: true
  validates :title, presence: true, length: {maximum: 40}
  validates_with TitleValidator


  def previous_five
    newln = Line.where(:corpse_id => self.id, :count => self.counter-1).first
    lstln = newln.text
    llstln = lstln.split
    llstln[-5..-1].join(" ")
  end

  def send_to_next
    self.counter += 1
    self.save
  end

  private

  def style=(name)
    self.style = Style.find_or_create_by(name)
  end

end
