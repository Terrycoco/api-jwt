class User < ActiveRecord::Base

  #email verification
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save { email.downcase! }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}

  #use Bcrypt for password over SSL
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def fullname
    return self.firstname + ' ' + self.lastname
  end
end
