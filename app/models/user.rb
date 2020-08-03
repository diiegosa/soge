class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :profile

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_confirmation, presence: true, on: :update, if: :password_changed?
  validate :verify_current_password, on: :update, if: :password_changed?

  attr_accessor :current_password
  
  def password_changed?
      !current_password.blank?
  end

  def verify_current_password
    errors.add(:base, "Senha atual incorreta") unless User.find(self.id).valid_password?(current_password)
  end

  def is_admin?
    return self.profile.nil? ? false : self.profile.admin
  end

  def password_update(params)
    self.current_password = params[:current_password]
    self.password = params[:password]
    self.password_confirmation = params[:password_confirmation]
    self.save
  end

end
