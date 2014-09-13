class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :devices

  before_save :generate_token

  private
    def generate_token
      return unless self.token.nil?
      self.token = loop do
        token = SecureRandom.urlsafe_base64
        break token unless User.exists?(token: token)
      end
    end
end
