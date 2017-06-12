class Style < ApplicationRecord
  has_many :corpses
  before_save validates :name, uniqueness: {:case_sensitive => false}, if:  :newest_style?

  def newest_style?
    self.id.nil?
  end


end
