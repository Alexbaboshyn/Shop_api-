class Admin::BalancesController < BaseController

private

  def build_resource
    @balance = Balance.new params
  end


  def resource
    @balance
  end

end
