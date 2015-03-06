class Wiki < ActiveRecord::Base
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  default_scope {order('Title ASC')}
  scope :visible_to, -> (user) do
    if user.admin? || user.premium?
      all
    else
      where(private: nil)
    end
  end
end
