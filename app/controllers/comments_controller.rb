class CommentsController < ApplicationController
  before_filter :find_post
  before_filter :authenticate_user!

  def new
    @comment=@post.comments.build
  end

  def destroy
  end

  def create
    @comment=@post.comments.build(params[:comment].merge!(user: current_user))
    if @comment.save
      flash[:notice] = "Comment has been saved."
      redirect_to root_path
    else
      flash[:alert] = "Comment has not been created."
      render :action => "new"
    end
  end

  def show

  end

  private

    def find_post
      @post = Post.find(params[:post_id])
    end
end
