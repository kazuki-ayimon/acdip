class Api::V1::ArticleCommentsController < Api::V1::ApplicationController
  before_action :authenticate_user!, except: %i[index]

  def create
    @article_comment = current_user.article_comments.build(article_comment_params)
    if @article_comment.save
      render './api/v1/article_comments/success', locals: { notice: I18n.t('notice.article_comment.create') }
    else
      render './api/v1/failure', locals: { alert: I18n.t('alert.article_comment.create') }, status: :unprocessable_entity
    end
  end

  def destroy
    article_comment = current_user.article_comments.find(params[:id])

    if article_comment.destroy
      render './api/v1/article_comments/success', locals: { notice: I18n.t('notice.article_comment.destroy') }
    else
      render './api/v1/failure', locals: { alert: I18n.t('alert.article_comment.destroy') }, status: :unprocessable_entity
    end
  end

  private

  def article_comment_params
    params.require(:article_comment).permit(:content, :user_id, :article_id)
  end
end
