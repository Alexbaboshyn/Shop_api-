class Api::ProfilesController < ApplicationController

  def balance
    current_user.increment(:balance, params[:user][:amount].to_i).save!
    render 'create.json.erb'
  end

  def resource
    @user = current_user
  end

end
