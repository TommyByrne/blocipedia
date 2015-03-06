class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates_presence_of :name, :email
  validates :email, format: /\b[a-zA-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\b/

  has_many :collaborators
  has_many :collaborations, through: :collaborators, source: :wiki
  has_many :wikis


  after_initialize :init

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

  def toggle_role
    @user = current_user

    if @user.admin? == 'admin'
      flash[:error] = "User is an admin. No update."
    elsif @user.standard?
      @user.update_attribute(:role, 'premium')
      flash[:notice] = "User switced from from standard to premium."
    else
      @user.update_attribute(:role, 'standard')
      flash[:notice] = "User switced from premium to standard."
    end
    redirect_to users_upgrade_path
  end

  def go_premium
    @user = current_user
    @user.update_attribute(:role, 'premium')
  end

  def go_standard
    @user = current_user
    @user.update_attribute(:role, 'standard')
    flash[:notice] = "User switched from premium to standard."
    redirect_to edit_user_registration_path
  end
end