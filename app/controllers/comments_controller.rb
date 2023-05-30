class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
  
    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@commentable.user, @commentable], notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: [@commentable.user, @commentable] }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = @commentable.user
    if @commentable.is_a?(Report)
      @report = @commentable
    elsif @commentable.is_a?(Book)
      @book = @commentable
    end
    @comments = @commentable.comments
  end
  

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to [@commentable.user, @commentable], notice: 'Comment was successfully updated.' }
        format.json { render json: @comment, status: :ok, location: [@commentable.user, @commentable] }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to [@commentable.user, @commentable], notice: 'Comment was successfully destroyed.', status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_commentable
    if params[:report_id]
      @commentable = Report.find(params[:report_id])
    else params[:book_id]
      @commentable = Book.find(params[:book_id])
    end
  end

  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
