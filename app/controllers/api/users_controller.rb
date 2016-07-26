class Api::UsersController < ApplicationController
skip_before_action :authenticate, only: [:create]

  # def update
  #   current_user.increment(:balance, params[:user][:amount].to_i).save!
  #   render 'create.json.erb'
  # end

  private

  def build_resource
    @user = User.new resource_params
  end

  def resource
      @user
    # @user = current_user
  end

  def resource_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
