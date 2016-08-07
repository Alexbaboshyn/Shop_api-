class Balance
  include ActiveModel::Model

  attr_accessor :amount, :user

  validates :amount, presence: true, numericality:
  
  def initialize params

    params = params.try(:symbolize_keys) || {}

    @amount = params[:amount]

    @user = params[:current_user]

  end

  validate do |model|
      model.errors.add :balance, 'balance can not be lower tan 0' unless user.balance >= 0
  end


  def save!
    user.increment(:balance, amount.to_i)
    raise ActiveModel::StrictValidationFailed unless valid?
    user.save!
  end


  def decorate
    user.decorate
  end
end
