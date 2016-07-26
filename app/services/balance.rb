class Balance
  include ActiveModel::Model

  attr_accessor :amount, :user

  validates :amount, presence: true, numericality: {greater_than_or_equal_to: 0}

  def initialize params

    params = params.try(:symbolize_keys) || {}

    @amount = params[:amount]

    @user = params[:current_user]

  end


  def update
    raise ActiveModel::StrictValidationFailed unless valid?
    user.increment(:balance, amount.to_i).save!
  end

  def decorate
    user
  end
end
