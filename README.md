# Acdip

「Acdip(アクディプ)」は、`積極的な防災（Active disaster Prevention）`がコンセプトの防災知識を身につけるために切磋琢磨し合うサービスです。
<br />

# 機能一覧

### ユーザーに関連する機能
 - [x] 新規登録
 - [x] ログイン
 - [ ] ゲストログイン
 - [x] ログアウト
 - [ ] 登録情報の編集(名前,画像,profile,メールアドレス,パスワード)
 - [ ] ユーザーページの表示(作成した記事,作成したコミュニティ,所属コミュニティの表示)
 - [ ] リアルタイム通知(チャットルームへの招待,コミュニティへの参加など)

### 管理者機能
 - [ ] ユーザー情報一覧,削除機能
 - [ ] 記事一覧,削除機能
 - [ ] コミュニティ情報一覧,削除機能

### コミュニティに関連する機能
 - [ ] コミュニティの作成
 - [ ] コミュニティの検索
 - [ ] コミュニティの編集(名前,トップ画像,背景画像,ゲームタイトル,公開設定)
 - [ ] チャットルーム作成
 - [ ] チャットルームへユーザーを招待
 - [ ] 招待通知からチャットルームに参加
 - [ ] リアルタイムチャット
 - [ ] 所属コミュニティの表示

<br />

# 使用技術

**フロントエンド**
| 名称 | 詳細 |
----|---- 
| Nuxt.js 2.15.8(SPA) | フロントエンドフレームワーク |
| Vuetify | UIライブラリ |
| Jest | テスト |

<br />

**バックエンド**
| 名称 | 詳細 |
----|---- 
| Ruby on Rails 6.1.5 | APIサーバーとして利用 |
| Action Cable | リアルタイム通信 |
| RuboCop | コード解析 |
| RSpec | model/requestのテスト |

<br />

**インフラ周り**
※今後追加

<br />

# AWS構成図
※今後追加

<br />

# ER図
![ER図]()


# コミットメッセージのプレフィックス

|  prefix  | 内容 |
|----------|------|
| feat     |  新機能 |
| fix      |  バグの修正 |
| style    |  コード内容に影響を与えない変更 <br> 例. white-space, formatting, missing semi-colons |
| refactor |  リファクタリング<br> バグの修正も機能の追加も行わないコード変更 |
| perf     |  パーフォマンスを向上させるための変更 |
| test     |  テストの追加・修正 |
