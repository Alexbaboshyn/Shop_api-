class User < ActiveRecord::Base

  enum role: [:user, :admin, :super_admin]

  has_secure_password

  has_many :orders, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_one :auth_token, dependent: :destroy
  has_many :gift_certificates

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true
  validates :balance, numericality: {greater_than_or_equal_to: 0}
  validates :bonus_points, numericality: {greater_than_or_equal_to: 0}


end
