class GiftCertificate < ActiveRecord::Base
  belongs_to :user
  belongs_to :order

  validates :token, presence: true
  validates :amount, presence: true, numericality: {greater_than: 0}

  before_validation :generate_token

  scope :unused, -> { where(order_id: nil) }

  def generate_token
    self.token = SecureRandom.uuid
  end

end
