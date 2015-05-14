class User < ActiveRecord::Base
  attr_reader :password

  after_initialize :ensure_session_token

  validates :username, :password_digest, presence: true
  validates :username, uniqueness: true

  validates :password, length: { minimum: 6, allow_nil: true }

  def self.create_session_token
    SecureRandom.urlsafe_base64
  end

  def self.find_by_credentials(params)
    user = User.find_by(username: params[:username])
    if user && user.is_password?(params[:password])
      user
    else
      nil
    end
  end

  def ensure_session_token
    self.session_token ||= User.create_session_token
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = User.create_session_token
    self.save!
    self.session_token
  end
end
