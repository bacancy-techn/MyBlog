class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
 
  def index
    @comments = Comment.all.order('created_at DESC')
  end

  
  def show
  end

  def create    
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user_id = current_user.id
    @comment.save
    flash[:success] = "Comment created successfuly"
    redirect_to post_path (@comment.post) 
  end
  
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # allow trusted parameters
    def comment_params
      params.require(:comment).permit(:content)
    end
end
