class ApplicationController < ActionController::API
  # TODO ここに共通処理を記述する
  # ログ出力
  #

  # エラーハンドリング
  # rescue_from StandardError, with: :response_internal_server_error
  rescue_from ActiveRecord::RecordNotFound , with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :unpermitted_parameters

  # MEMO: 仮実装(ログインユーザー)
  def current_user
    @current_user ||= User.find(1)
  end

private

  # 200 Success
  def response_success(data)
    render status: :ok, json: data
  end

  # 404 Not Found(DBからレコードが見つからなかった場合の処理)
  def record_not_found
    render status: :not_found, json: { status: 404, message: 'リソースが存在しません' }
  end

  def unpermitted_parameters
    render status: :bad_request, json: { status: 400, message: '不正なパラメータです' }
  end

  # 500 Internal Server Error
  # def response_internal_server_error(e = nil)
  #   error_log(e) if e.present?
  #   render status: :internal_server_error, json: {message: e}
  # end

  def response_custom_error(message, status)
    render json: { error: message }, status: status
  end
end
