class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates_presence_of :name, :email
  validates :email, format: /\b[a-zA-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\b/

  has_many :collaborators
  has_many :collaborations, through: :collaborators, source: :wiki
  has_many :wikis


  after_initialize :init

  def self.search(search)
    search_condition = "%" + search + "%"
    where('name LIKE ? OR email LIKE ?', search_condition, search_condition)
  end

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

   def upgrade
    @user = current_user
  end
end