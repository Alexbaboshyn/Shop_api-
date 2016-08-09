class Admin::BalancesController < BaseController

private
  def build_resource
    @balance = Balance.new(params.merge(resource_params))
  end

  def resource
    @balance
  end

  def resource_params
    params.require(:balance).permit(:amount)
  end
end
