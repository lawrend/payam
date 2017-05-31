class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  validates_uniqueness_of :username
  attr_accessor :login

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end
end
