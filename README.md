# Ruby on Railsを使ったWebAPIの開発

## なくしんぼう(本サービス名) 要件定義書

### 1. プロジェクトの目的と概要
   - 1.1 目的
      - イベント会場等での落とし物や迷子の子の情報管理を紙からWebでの管理にしてDX化を図りたい

   - 1.2 プロジェクト概要
      - 以下に示す機能を実装したWebアプリケーションを開発する

### 2. 機能要件
   - 2.1 機能要件
      ※細かな仕様は[issue]()に記載する
      - 2.1.1 [アカウント管理機能]
         - スタッフの登録：イベントに参加するスタッフがアカウントを作成できる。
         - ログイン/ログアウト：登録済みスタッフがアカウントにログインしたり、ログアウトできる。
      - 2.1.2 [イベントの登録機能]
         - イベントの登録機能：イベントの登録ができる。

      - 2.1.3 [イベント会場の預かりセンターの登録機能]
         - イベント会場の預かりセンターの登録：スタッフが拾った落とし物や迷子の子を預かるセンターを登録できる。
         - 写真のアップロード：預かりセンターの写真をアップロードできる。

      - 2.1.4 [落とし物登録機能]
         - 落とし物情報の登録：スタッフが落とし物の情報（例：品物の特徴、場所、紛失時刻）を登録できる。
         - 写真のアップロード：落とし物の写真をアップロードできる。

      - 2.1.5 [迷子情報登録機能]
         - 迷子の情報の登録：スタッフが迷子の情報（例：子供の特徴、最終目撃時刻）を登録できる。
         - 写真のアップロード：迷子の写真をアップロードできる。

      - 2.1.6 [検索機能]
         - 検索機能：スタッフが落とし物の情報をもとに検索できる。

   - 2.2 その他の要件
      - フレームワーク: Ruby on Railsを使用するものとする。
      - フロントエンドは実装しない。
      - Ruby 2.6.5
      - Rails 6.1.3
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

         ```
            // スタッフ
            create_table "users", force: :cascade do |t|
               t.string "name", null: false
               t.string "email", default: "", null: false
               t.string "tel"
               t.bigint "role_id", null: false
               t.string "encrypted_password", default: "", null: false
               t.string "reset_password_token"
               t.datetime "reset_password_sent_at"
               t.datetime "remember_created_at"
               t.datetime "created_at", precision: 6, null: false
               t.datetime "updated_at", precision: 6, null: false

               t.index ["email"], name: "index_users_on_email", unique: true
            end

            // 中間テーブル
            create_table "user_projects", force: :cascade do |t|
               t.boolean "is_manager"
               t.bigint "user_id", null: false
               t.bigint "project_id", null: false
               t.datetime "created_at", precision: 6, null: false
               t.datetime "updated_at", precision: 6, null: false

               t.index ["project_id"], name: "index_user_projects_on_project_id"
               t.index ["user_id"], name: "index_user_projects_on_user_id"
            end

            // イベント
            create_table "projects", force: :cascade do |t|
               t.string "name", null: false
               t.datetime "start_at", null: false
               t.datetime "end_at", null: false
               t.string "place"
               t.datetime "created_at", precision: 6, null: false
               t.datetime "updated_at", precision: 6, null: false
            end

            // 迷子預かりセンター
            create_table "lost_person_storages", force: :cascade do |t|
               t.string "name"
               t.bigint "project_id", null: false
               t.datetime "created_at", precision: 6, null: false
               t.datetime "updated_at", precision: 6, null: false

               t.index ["project_id"], name: "index_lost_person_storages_on_project_id"
            end

            // 迷子画像
            create_table "lost_person_images", force: :cascade do |t|
               t.string "content"
               t.bigint "lost_person_id", null: false
               t.datetime "created_at", precision: 6, null: false
               t.datetime "updated_at", precision: 6, null: false
               t.index ["lost_person_id"], name: "index_lost_person_images_on_lost_person_id"
            end

            // 迷子
            create_table "lost_people", force: :cascade do |t|
               t.string "name"
               t.string "kana"
               t.integer "gender"
               t.integer "age"
               t.integer "tall"
               t.datetime "reception_at"
               t.integer "status"
               t.datetime "discover_at"
               t.string "discover_spot"
               t.string "jacket_color"
               t.string "jacket_character"
               t.string "bottoms_color"
               t.string "bottoms_character"
               t.string "shoes_color"
               t.string "shoes_character"
               t.string "cap_color"
               t.string "items"
               t.string "hair_style"
               t.string "comment"
               t.bigint "lost_person_storage_id", null: false
               t.bigint "project_id", null: false
               t.bigint "handler_staff_id"
               t.datetime "created_at", precision: 6, null: false
               t.datetime "updated_at", precision: 6, null: false

               t.index ["handler_staff_id"], name: "index_lost_people_on_handler_staff_id"
               t.index ["lost_person_storage_id"], name: "index_lost_people_on_lost_person_storage_id"
               t.index ["project_id"], name: "index_lost_people_on_project_id"
            end

            // 落とし物画像
            create_table "found_images", force: :cascade do |t|
               t.string "content"
               t.datetime "created_at", precision: 6, null: false
               t.datetime "updated_at", precision: 6, null: false

               t.index ["found_id"], name: "index_found_images_on_found_id"
            end

            // 落とし物預かりセンター
            create_table "found_storages", force: :cascade do |t|
               t.string "name", null: false
               t.bigint "project_id", null: false
               t.datetime "created_at", precision: 6, null: false
               t.datetime "updated_at", precision: 6, null: false

               t.index ["project_id"], name: "index_found_storages_on_project_id"
            end

            // 落とし物
            create_table "founds", force: :cascade do |t|
               t.string "name", null: false
               t.string "finding_spot"
               t.string "comment"
               t.string "owner_name"
               t.string "owner_tel"
               t.string "reception_number"
               t.string "discoverer"
               t.datetime "finding_at"
               t.bigint "found_storage_id"
               t.bigint "project_id", null: false
               t.datetime "created_at", precision: 6, null: false
               t.datetime "updated_at", precision: 6, null: false

               t.index ["found_storage_id"], name: "index_founds_on_found_storage_id"
               t.index ["project_id"], name: "index_founds_on_project_id"
            end
         ```
   - 3.1.2 ER図
       - 準備中

### 4. リリース計画
   - 4.1 目標は1.5ヶ月です
      ※開発のスケジュールの詳細は[issue]()に記載する

### 5. その他

   - 5.1 参考文献
      - [Railsドキュメント](https://railsdoc.com/)
      - [Rails諸々まとめ](https://github.com/RairuDev/Rails_Practice)

### 6. 進め方・注意事項

   - まず最初に環境構築をするために、[環境構築]()を参考に環境構築をしてください
   - 開発に入る前に要件に対しての見積もりを出してください
   - 機能要件に対して[進め方のテンプレート]()を記載してください
   - 作業はブランチを切って行ってください
      - ブランチ名は`feature/issueの番号`でお願いします
   - プルリクエストを出してください
   - レビュアーを自分にしてください(自分がマージします)
   - マージされた後はブランチを削除します(自分が削除します)
   - 学んだことはどんどんSlackのチャンネルに共有してください
      - 1つの要件に対して最低1つは共有してください
   - 見積もりから過ぎそうなときは、Slackで自分宛に連絡してください
      - 必ず早めの相談をお願いします
         ※本来の案件では直前の相談はNGなのでその練習も兼ねています
   - 詰まったら早めに連絡をお願いします
      - [質問テンプレート]()を使ってください
         ※実装の場合のみ必須
      - 仕様についてはすぐに質問してください
   - commitメッセージは日本語で大丈夫ですので、わかりやすいメッセージをお願いします
