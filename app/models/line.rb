class Line < ApplicationRecord
  belongs_to :auth, :class_name => "User"
  belongs_to :corpse, optional: true

end
