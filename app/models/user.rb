class User < ActiveRecord::Base
  has_many :wikis
  after_initialize :init

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def admin?
    role == 'admin'
  end

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end
  def init
    self.role ||= 'standard'
  end
end