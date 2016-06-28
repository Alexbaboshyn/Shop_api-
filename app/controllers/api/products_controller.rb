class Api::ProductsController < ApplicationController
  skip_before_action :authenticate

  private
  def collection
    @products ||= Product.search_by(params)
  end

  def resource
    @products ||= Product.find params[:id]
  end

end
