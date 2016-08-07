class Api::BalancesController < ApplicationController

private
  def build_resource
    @balance = Balance.new(resource_params.merge(current_user: current_user))
  end

  def resource
    @balance
  end

  def resource_params
    params.require(:balance).permit(:amount)
  end
end
