class Wiki < ActiveRecord::Base
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators
  belongs_to :user


  scope :visible_to, -> (user) do
    if user.admin? || user.premium?
      all
    else
      where(private: false)
    end
  end
end
