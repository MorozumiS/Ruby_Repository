class ApplicationController < ActionController::API
  # 独自の例外クラスを作成
  class User::NotAuthorizedError < Exception; end
  before_action :verify_token
  # include ActionController::Cookies
  # TODO: 例外発生時にログ出力

  # エラーハンドリング
  # rescue_from StandardError, with: :response_internal_server_error
  rescue_from JWT::VerificationError, with: :unauthorized_access
  rescue_from User::NotAuthorizedError, with: :not_authorized_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :unpermitted_parameters

  private

  # 200 Success
  def response_success(data)
    render status: :ok, json: data
  end

  # 400 Bad Request(不正なパラメータが送られてきた場合の処理)
  def unpermitted_parameters
    render status: :bad_request, json: { status: 400, message: '不正なパラメータです' }
  end

  # 401 User::NotAuthorizedError(ユーザー認証が失敗した時の処理)
  def not_authorized_error
    render status: :unauthorized, json: { status: 401, message: 'メールアドレスもしくはパスワードが適切ではありません' }
  end

  # 403 JWT::ExpiredSignature(JWT認証によるアクセストークンが正しくない場合の処理)
  def unauthorized_access
    render status: :forbidden, json: { status: 403, message: 'アクセス権がありません' }
  end

  # 404 Not Found(DBからレコードが見つからなかった場合の処理)
  def record_not_found
    render status: :not_found, json: { status: 404, message: 'リソースが存在しません' }
  end

  # [WIP]500 Internal Server Error
  # def response_internal_server_error(e = nil)
  #   error_log(e) if e.present?
  #   render status: :internal_server_error, json: {message: e}
  # end

  def response_custom_error(message, status)
    render json: { error: message }, status: status
  end

  def render_error_response(message_key, status)
    message = I18n.t("response.message.#{message_key}")
    render json: { error: message }, status: status
  end

  def verify_token
    auth_header = request.headers['Authorization']
    return render status: :unauthorized unless auth_header

    # 実際のトークンは2番目に格納されているため
    token = auth_header.split(' ')[1]
    begin
      payload, = JWT.decode(token, 'secret')
    rescue JWT::ExpiredSignature
      render status: :forbidden
    end
  end
end
