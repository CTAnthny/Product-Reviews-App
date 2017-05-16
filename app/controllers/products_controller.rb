class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all.order(updated_at: :desc).page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @user = current_user
    @product = Product.new(product_params)
    @product.user_id = @user.id

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
