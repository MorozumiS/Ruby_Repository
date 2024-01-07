# Ruby on Railsを使ったWebAPIの開発

##  要件定義書

### 1. プロジェクトの目的と概要
   - 1.1 目的
      - イベント会場等での落とし物や迷子の情報を紙からWebでの管理にしてDX化を図りたい

   - 1.2 プロジェクト概要
      - 以下に示す機能を実装したWebアプリケーションを開発する

### 2. 機能要件
   - 2.1 機能要件
      ※細かな仕様は課題に記載
      - 2.1.1 [イベントのCRUD機能]
         - イベントの登録機能：イベントの登録ができる。
         - 一覧は実装しなくて大丈夫です

      - 2.1.2 [イベント会場の預かりセンターのCRUD機能]
         - イベント会場の預かりセンター：スタッフが拾った落とし物や迷子の子を預かる場所
         - 詳細・削除は実装しなくて大丈夫です

      - 2.1.3 [落とし物CRUD機能]
         - 落とし物情報：スタッフが落とし物を拾った際に情報（例：品物の特徴、場所、持ち主の情報）を管理できる
         - 写真の登録：落とし物の写真を登録できる。
         - 詳細・更新は実装しなくて大丈夫です

      - 2.1.4 [迷子情報CRUD機能]
         - 迷子の情報：スタッフが迷子の情報（例：子供の特徴、最終目撃時刻）を管理できる。
         - 写真の登録：迷子の写真を登録できる。
         - 一覧・詳細・削除は実装しなくて大丈夫です

      - 2.1.5 [検索機能]
         - 検索機能：スタッフが迷子の情報を条件を元に検索できる。

   - 2.2 その他の要件
      - フレームワーク: Ruby on Railsを使用するものとする。
      - フロントエンドは実装しない。
      - Ruby 2.7.4
      - Rails 6.1.7.4
      - DBはMySQL
      - テストはRSpec
      - 認証
        - devise
      - 論理削除
         - discard
      - ファイルアップロード関連
         - carrierwave
         - carrierwave-base64
         - mini_magick
      - デバック
         - pry-rails
         - pry-byebug

### 3. 仕様
   - 3.1 データベース仕様
      - 3.1.1 テーブル定義書

ユーザーテーブル(users)

| カラム名  | カラム名（日本語） | 型 | バリデーション | 備考 | 
| ------------- | ------------- | ------------- | ------------- | ------------- |
|name|名前|string| null: false | |
|kana|カナ|string|  | |
|email|メールアドレス|string| null: false |  |
|tel|電話番号|string| null: false | |
|role|権限|int| null: false | |
|uid|ユーザー識別子|string| null: false |  |
|last_sign_in_at|最終ログイン日時|datetime|  |  |
|created_at|登録日時|datetime|null: false | |
|updated_at|更新日時|datetime|null: false | |
|deleted_at|削除日時|datetime| | |


イベントテーブル(projects)

| カラム名  | カラム名（日本語） | 型 | バリデーション | 備考 | 
| ------------- | ------------- | ------------- | ------------- | ------------- |
|name|イベント名|string|null: false| |
|start_at|イベント開始日|datetime|  |  |
|end_at|イベント終了日|datetime|  |  |
|place|場所|string| null: false | |
|user_id|ユーザーID|bigint|  | |
|created_at|登録日時|datetime|null: false | |
|updated_at|更新日時|datetime|null: false | |
|deleted_at|削除日時|datetime| | |

預かりセンターテーブル(lost_storages)

| カラム名  | カラム名（日本語） | 型 | バリデーション | 備考 | 
| ------------- | ------------- | ------------- | ------------- | ------------- |
|name|預かり場所名|string|null: false| |
|reception_number_prefix|識別記号|string| null: false |  |
|project_id|プロジェクトid|bigint|null: false  |  |
|created_at|登録日時|datetime|null: false | |
|updated_at|更新日時|datetime|null: false | |

落とし物テーブル(lost_items)

| カラム名  | カラム名（日本語） | 型 | バリデーション | 備考 | 
| ------------- | ------------- | ------------- | ------------- | ------------- |
|name|名前|string|null: false| |
|lost_spot|見つけた場所|string| null: false |  |
|comment|備考|string| | |
|owner_name|持ち主の名前|string|  |  |
|owner_tel|持ち主の電話番号|string| |  |
|owner_address|住所|string| | |
|features|特徴|string| | |
|project_id|プロジェクトのid|bigint|null: false  |  |
|lost_storage_id|預かりセンターのid|bigint|null: false  |  |
|created_at|登録日時|datetime|null: false | |
|updated_at|更新日時|datetime|null: false | |
|deleted_at|削除日時|datetime| | |

落とし物の画像テーブル(lost_item_images)

| カラム名  | カラム名（日本語） | 型 | バリデーション | 備考 | 
| ------------- | ------------- | ------------- | ------------- | ------------- |
|content|画像|string|null: false| |
|lost_item_id|落とし物のid|bigint| null: false |  |
|created_at|登録日時|datetime|null: false | |
|updated_at|更新日時|datetime|null: false | |
|deleted_at|削除日時|datetime| | |

迷子のテーブル(lost_people)

| カラム名  | カラム名（日本語） | 型 | バリデーション | 備考 | 
| ------------- | ------------- | ------------- | ------------- | ------------- |
|name|名前|string|null: false| |
|kana|カナ|string| null: false |  |
|gender|性別|string|null: false| |
|age|年齢|string| null: false |  |
|tall|身長|string|null: false| |
|reception_at|発見時刻|string| null: false |  |
|status|ステータス|int|null: false| |
|project_id|プロジェクトid|bigint|null: false  |  |
|lost_storage_id|預かりセンターのid|bigint|null: false  |  |
|lost_person_image_id|迷子の画像のid|bigint|null: false  |  |
|created_at|登録日時|datetime|null: false | |
|updated_at|更新日時|datetime|null: false | |
|deleted_at|削除日時|datetime| | |

迷子の画像テーブル(lost_person_images)

| カラム名  | カラム名（日本語） | 型 | バリデーション | 備考 | 
| ------------- | ------------- | ------------- | ------------- | ------------- |
|content|画像|string|null: false| |
|lost_person_id|迷子のid|bigint| null: false |  |
|created_at|登録日時|datetime|null: false | |
|updated_at|更新日時|datetime|null: false | |
|deleted_at|削除日時|datetime| | |


### 4. 進捗計画
   - 4.1 目標は1ヶ月
    - 環境構築・動作確認・仕様把握　1日
    - [Back-01](https://ring-tech.backlog.com/view/TRAINING-30)　2日
    - [Back-02](https://ring-tech.backlog.com/view/TRAINING-34)　1日
    - [Back-03](https://ring-tech.backlog.com/view/TRAINING-35)　1日
    - [Back-04](https://ring-tech.backlog.com/view/TRAINING-36)　1日
     - [Back-05](https://ring-tech.backlog.com/view/TRAINING-31)　1日
     - [Back-06](https://ring-tech.backlog.com/view/TRAINING-37)　1日
     - [Back-07]()　1日
     - [Back-08](https://ring-tech.backlog.com/view/TRAINING-32)　3日
     -  [Back-09](https://ring-tech.backlog.com/view/TRAINING-38)　1日
     -  [Back-10]()　1日
     - [Back-11](https://ring-tech.backlog.com/view/TRAINING-33)　2日
     - [Back-12]()　1日
     - [Back-13](https://ring-tech.backlog.com/view/TRAINING-39)　2日

### 5. 進め方・注意事項

   - まず最初に環境構築をするために、[資料](https://ring-tech.backlog.com/view/TRAINING-28)を参考に環境構築をしてください
   - 開発に入る前にタスクに対しての見積もりを出してください
   <!-- 一旦無しで進める -->
   <!-- - 機能要件に対して[進め方のテンプレート](https://github.com/RairuDev/LostService/issues/3)を記載してください -->
   - 作業はブランチを切って行ってください
      - ブランチ名は`feature/Backの番号`でお願いします
   - プルリクエストを出してください
   - レビュアーを自分と中泊さんに設定してください(私達でマージします)
   - マージされた後はブランチを削除します(自分が削除します)
   - 学んだことはどんどんSlackのチャンネルに共有してください
      - 目安：1つの要件に対して1つ
   - 見積もりから過ぎそうなときは、Slackで自分宛に連絡してください
      - 必ず早めの相談をお願いします
         ※本来の案件では直前の相談はNGなのでその練習も兼ねています
   - 詰まったら早めに連絡をお願いします
      - [質問テンプレート](https://ring-tech.backlog.com/view/TRAINING-40)を使ってください
         ※実装の場合のみ必須
      - 仕様についてはすぐに質問してください
   - commitメッセージは日本語で大丈夫ですので、わかりやすいメッセージをお願いします

### 6. 参考文献
  - [Railsドキュメント](https://railsdoc.com/)
  - [Rails諸々まとめ](https://github.com/RairuDev/Rails_Practice)
   - APIの動作確認は[Postman](https://www.postman.com/)を使ってください
      - [Postmanの使い方](https://circleci.com/ja/blog/testing-an-api-with-postman/)

   - [ステータスコード](https://qiita.com/uenosy/items/ba9dbc70781bddc4a491)
   - [REST API](https://tech.012grp.co.jp/entry/rest_api_basics)
   - [Git](https://www.slideshare.net/kotas/git-15276118)
   - [Git-flow](https://qiita.com/KosukeSone/items/514dd24828b485c69a05)