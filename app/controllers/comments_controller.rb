# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  before_action :verify_current_user, only: %i[edit update destroy]

  # GET /commentable/1/comments/1/edit
  def edit; end

  # POST /commentable/1/comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @comment.commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render :new
    end
  end

  # PATCH/PUT /commentable/1/comments/1
  def update
    if @comment.update(comment_params)
      redirect_to @comment.commentable, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render :new
    end
  end

  # DELETE /commentable/1/comments/1
  def destroy
    @comment.destroy
    redirect_to @comment.commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type).merge(user: current_user)
  end

  def verify_current_user
    comment = Comment.find(params[:id])
    redirect_to comment.commentable, alert: t('controllers.common.alert_incorrect_user') if comment.user != current_user
  end
end
