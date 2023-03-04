# Readme

## 【非公式】ストレングスファインダーエピソード共有アプリ
サイトURL: https://strengths-app.onrender.com/<br>
オンラインコミュニティ『リベシティ』ユーザー向けに、ストレングスファインダーに関する自分のエピソードを投稿できるサイトを作成しました。<br>
※当サイトはリベシティユーザーのみ利用できる仕様となっております。<br>
実際の動きはmainブランチをpullしていただき、ローカル環境で確認していただくようお願いします。<br>
サイトの動作について説明した記事をQiitaに限定公開しました。<br>
https://qiita.com/yatchi_323/private/968f9121139472fceffe

### テストログイン方法
ローカル環境にて、下記プロフィールURLとパスワードを使用してログインすることができます。<br>
プロフィールURL: https://\libecity.com/user_profile/test <br>
パスワード: foobar


## 使用技術
+ Ruby 3.1.2
+ Rails 7.0.4
+ VScode
+ データベース
  + 開発・テスト環境: SQLite3 3.39.5
  + 本番環境: PostgreSQL 14.6
  + 画像ストレージ: AWS S3
+ Paas
  + Render.com
+ フロント技術
  + Tailwind CSS
+ minitest

## ER図
<img width="679" alt="67735b54effc56c31b7e0f3a67816c37" src="https://user-images.githubusercontent.com/74131105/222872076-8bc95058-1f10-46cd-9ca2-8bff533298ea.png">


## 機能一覧
+ ユーザー登録、ログイン
  + アイコン・資質一覧の画像登録(Active Storage)
  + フォロー機能
  + 自作バリデーション
+ 投稿機能
  + 資質のタグ付け機能(他のユーザーもタグ付け可能)
+ 無限スクロール(Turbo Frames)
+ 検索機能(ransack)


## テスト
+ 単体テスト(models)
+ 機能テスト(controllers)
+ 統合テスト(integration)