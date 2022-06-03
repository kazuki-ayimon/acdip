module.exports = {
  // 【ユーザー】
  // ログインAPI
  authSignInURL: '/api/v1/users/auth/sign_in.json',
  authRedirectSignInURL: '/signin',
  authRedirectHomeURL: '/',
  // ログアウトAPI
  authSignOutURL: '/api/v1/users/auth/sign_out.json',
  authRedirectLogOutURL: '/signin',
  // トークン検証API
  authUserURL: '/api/v1/users/auth/validate_token.json',
  // アカウント登録API
  singUpUrl: '/api/v1/users/auth/sign_up.json',
  singUpSuccessUrl: '/signin',
  // パスワード再設定API
  passwordNewUrl: '/api/v1/users/auth/password.json',
  passwordRedirectUrl: '/password/reset/confirm',
  passwordUpdateUrl: '/api/v1/users/auth/password/update.json',
  // 登録情報詳細API
  userShowUrl: '/api/v1/users/auth/show.json',
  // 登録情報変更API
  userUpdateUrl: '/api/v1/users/auth/update.json',
  // 画像変更API
  userImageUpdateUrl: '/api/v1/users/auth/image/update.json',
  // 画像削除API
  userImageDeleteUrl: '/api/v1/users/auth/image/delete.json',
  // アカウント削除API
  userDeleteUrl: '/api/v1/users/auth/delete.json',

  // 【お知らせ】
  // 大切なお知らせAPI
  importantInfomationsUrl: '/api/v1/infomations/important.json',
  // お知らせ一覧API
  infomationsUrl: '/api/v1/infomations.json',
  // お知らせ詳細API
  infomationDetailUrl: '/api/v1/infomations/_id.json',

  // 【記事】
  // 記事一覧API
  articlesUrl: '/api/v1/articles.json',
  // 記事詳細API
  articleDetailUrl: '/api/v1/articles/_id.json',
  // 記事作成API
  articleCreateUrl: '/api/v1/articles/create.json',
  // 記事編集API
  articleUpdateUrl: '/api/v1/articles/_id/update.json',
  // 記事削除API
  articleDeleteUrl: '/api/v1/articles/_id/delete.json',
  // 記事検索API
  articlesSearchUrl: '/api/v1/articles/search.json',
  // 記事カテゴリー検索API
  articlesCategoryUrl: '/api/v1/articles/category.json',

  // ［お気に入り］
  // お気に入り登録API
  favoriteCreateUrl: '/api/v1/articles/_id/article_favorites/create.json',
  // お気に入り解除API
  favoriteDeleteUrl: '/api/v1/articles/_id/article_favorites/delete.json',

  // ［コメント］
  // コメント一覧API
  commentsUrl: '/api/v1/article_comments.json',
  // コメント作成API
  commentCreateUrl: '/api/v1/article_comments/create.json',
  // コメント削除API
  commentDeleteUrl: '/api/v1/article_comments/_id/delete.json'
}
