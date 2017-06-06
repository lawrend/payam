class Line < ApplicationRecord
  belongs_to :auth, :class_name => "User"
  belongs_to :corpse, optional: true
  validates :text, presence: true
  validate :word_count


  private
  def word_count
    @count = text.scan(/[[:alpha:]]+/).count
    if @count < 10
      errors.add(:text, "That's #{10 - @count} too few words for the line.")
    elsif @count > 20
      errors.add(:text, "That's #{@count - 20} too many words for the line.")
    end
  end

end
