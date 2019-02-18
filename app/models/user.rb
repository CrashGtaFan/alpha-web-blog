class User < ActiveRecord::Base
  has_secure_password

  has_many :articles, dependent: :destroy
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       length: { minimum: 6, maximum: 25 }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    length: { maximum: 60 }, format: { with: VALID_EMAIL_REGEX }
  enum role: [:writer, :admin]
end
