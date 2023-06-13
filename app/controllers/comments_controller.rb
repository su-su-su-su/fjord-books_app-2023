# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable, only: %i[create update]
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.commentable = @commentable

    respond_to do |format|
      if @comment.save
        format.html { redirect_to polymorphic_url(@comment.commentable), notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
      else
        format.html { render :new }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to polymorphic_url(@comment.commentable), notice: t('controllers.common.notice_update', name: Comment.model_name.human) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html do
        redirect_to polymorphic_url(@comment.commentable), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human), status: :see_other
      end
    end
  end

  private

  def set_commentable
    if params[:report_id]
      @commentable = Report.find(params[:report_id])
    else
      params[:book_id]
      @commentable = Book.find(params[:book_id])
    end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
