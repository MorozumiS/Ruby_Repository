class ApplicationController < ActionController::API
  # TODO ここに共通処理を記述する
  # エラーハンドリング
  # レスポンス値の値
  # ログ出力
  #

  # MEMO: 仮実装(ログインユーザーを固定値で返却する)
  def current_user
    @current_user ||= User.find(id: 1)
  end
end
