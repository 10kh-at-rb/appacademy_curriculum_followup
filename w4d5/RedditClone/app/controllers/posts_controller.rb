class PostsController < ApplicationController

  def new
    @post = Post.new
    @sub_id = params[:sub_id]
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      flash[:success] = "Successfully created post"
      redirect_to sub_url(@post.sub)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "Post updated successfully"
      redirect_to sub_url(@post.sub_id)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end


  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end

end
