class CommentsController < ApplicationController
  before_action :authenticate_user_even_on_ajax!, except: :index
  before_action :find_commentable
  before_action :check_user, only: [:destroy]
  skip_after_action :store_location

  def index
    @comments = @commentable.comments
    respond_to do |format|
      format.js
    end
  end

  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    if @comment.save
      respond_to do |format|
        format.js
        format.html {redirect_to :back}
      end
    end
  end

  def destroy
    @comment.destroy
    redirect_to :back, notice: 'comment deleted'
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        klass = $1.classify.constantize
        if klass.method_defined? :comments
          @commentable = klass.find(value)
          return @commentable
        end
      end
    end
    nil
  end

 def check_user
   @comment = Comment.find(params[:id])
   unless (@comment.user_id == current_user.id && @comment.comments.size == 0)
     redirect_to :back, notice: 'No Permission to delete this comment!'
   end
 end

  def authenticate_user_even_on_ajax!
    unless user_signed_in?
      if request.xhr?
        render js: "window.location.pathname='#{new_user_session_path}'" and return
      end
    end
    authenticate_user!
  end
end
