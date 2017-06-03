class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  validates_uniqueness_of :username
  has_many :lines, :foreign_key => "auth_id"
  has_many :corpses, through: :lines

  def waiting
    Corpse.where(:current_scribe => self.id)
  end

end
