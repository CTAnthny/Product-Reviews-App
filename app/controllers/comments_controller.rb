class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:notice] = "Your review was successfully posted!"
      redirect_to @product
    else
      render "products/show"
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @product = @comment.product
  end

  def update
    @comment = Comment.find(params[:id])
    @product = @comment.product

    if @comment.update_attributes(comment_params)
      flash[:notice] = 'Your review has been updated!'
      redirect_to @product
    else
      render 'edit'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:description)
  end
end
