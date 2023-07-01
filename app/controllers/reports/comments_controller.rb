# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  before_action :set_report
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.commentable = @report

    if @comment.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to @report, alert: @comment.errors.full_messages.join(', ')
    end
  end

  def edit; end

  def update
    if current_user != @comment.user
      redirect_to @report
      return
    end

    if @comment.update(comment_params)
      redirect_to report_url(@report), notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    if current_user != @comment.user
      redirect_to report_url(@report)
      return
    end
    @comment.destroy

    redirect_to report_url(@report), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human), status: :see_other
  end

  private

  def set_report
    @report = Report.find(params[:report_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
