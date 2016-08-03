class Api::BalancesController < ApplicationController

  def update
    # Balance.new(resource_params.merge(current_user: current_user)).update
  resource.update
  end


  def resource
    @balance ||= Balance.new(resource_params.merge(current_user: current_user))
  end

private
  def resource_params
    params.require(:balance).permit(:amount)
  end
end
