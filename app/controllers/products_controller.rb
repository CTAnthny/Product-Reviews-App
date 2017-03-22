class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = 'Your product has been successfully submitted!'
      redirect_to @product
    else
      render 'new'
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :website)
  end
end
