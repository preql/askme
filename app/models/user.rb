require 'openssl'
require 'uri'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :username, length: { maximum: 40 },
            format: { with: /\A[a-zA-Z0-9\_]+\z/ }

  attr_accessor :password

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_validation :downcase_username
  before_save :encrypt_password

  private

  def encrypt_password
    if password.present?

      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )
    return user if user.password_hash == hashed_password
    nil
  end

  def downcase_username
    self.username.downcase! unless username.blank?
  end
end
