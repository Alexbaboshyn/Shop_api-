class Order < ActiveRecord::Base

  belongs_to :user
  has_many :purchases, dependent: :destroy
  has_many :gift_certificates

  # validates :purchases, presence: true
  # validates_presence_of :purchases

  enum status: [:pending, :accepted, :declained]

  scope :unpayed, -> { where(status: 0) }


after_create :fill_order_id_in_purchases

def fill_order_id_in_purchases
    self.purchases = Purchase.unordered.where(user_id: user_id)

    self.amount = self.purchases.inject(0){|q, value| q+=value.quantity*value.product.price}

    self.save
end

# def fill_order_id_in_purchases
#   purchases = Purchase.where(user_id: self.user_id, order_id: nil)
#   amount = 0;
#   purchases.each do |purchase|
#     purchase.update_attribute(:order_id, self.id)
#     amount += purchase.product.price * purchase.quantity
#   end
#   self.update_attribute(:amount, amount)
# end

end


# after_create :add_order_id_to_purchases

# def add_order_id_to_purchases
#   tovars = @current_user.purchases.where(order_id: nil)
#
#   amount = 0;
#   tovars.each do |purchase|
#     purchase.update_attribute(:order_id, self.id)
#
#     amount += purchase.product.price * purchase.quantity
#
#   end
#
#   self.update_attribute(:amount, amount)
#


# end
