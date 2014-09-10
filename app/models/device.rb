class Device < ActiveRecord::Base
  has_many :streams
  belongs_to :user

  before_create :generate_key

  scope :all_from_user, ->(curr_user) { where(user_id: curr_user) }

  private
    def generate_key
      self.key = loop do
        token = SecureRandom.urlsafe_base64
        break token unless Device.exists?(key: token)
      end
    end

end
