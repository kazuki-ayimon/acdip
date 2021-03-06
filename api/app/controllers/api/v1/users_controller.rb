class Api::V1::UsersController < Api::V1::ApplicationController

  # GET /api/v1/users/ranking(.json) ユーザーランキング取得API
  def index
    # ユーザーを獲得ポイント順に取得
    @users = User.point_ranking.page(params[:page]).per(Settings['default_users_limit'])
    render './api/v1/users/index'
  end

  # GET /api/v1/users/:username(.json) ユーザー情報詳細取得API
  def show
    @user = User.find_by(username: params[:username])
    @required_point = RequiredPoint.find_by(level: @user.level).point if @user.present?

    if @user.present? && @user.prefecture_id.present?
      @prefecture = Prefecture.find(@user.prefecture_id)
      @city = City.find(@user.city_id)
    end

    if @user
      render './api/v1/users/show'
    else
      head :not_found
    end
  end

  # GET /api/v1/users/:username/genres/:id(.json) ユーザーのジャンル別記事一覧取得API
  def genre_articles
    @user = User.find_by(username: params[:username])
    @genre = Genre.find(params[:id])
    if params[:favorite]
      # お気に入りした記事一覧を取得
      @articles = @user.favorited_articles.page(params[:page]).per(Settings['default_articles_limit']).joins(:article_genre_relations).where("genre_id = #{@genre.id}")
    else
      # 投稿した記事一覧を取得
      @articles = @user.articles.page(params[:page]).per(Settings['default_articles_limit']).joins(:article_genre_relations).where("genre_id = #{@genre.id}")
    end

    if @user
      render './api/v1/users/genre_articles'
    else
      head :not_found
    end
  end
end
