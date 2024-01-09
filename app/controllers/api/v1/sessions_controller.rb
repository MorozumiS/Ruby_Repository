class Api::V1::SessionsController < ApplicationController
  # 認証前のため、トークン認証をスキップする
  skip_before_action :verify_token, only: [:create]
  def create
    user = User.find_by(email: params[:email])
    # userが存在するかつ、パスワードが正しい場合
    # 参考: https://techracho.bpsinc.jp/hachi8833/2022_05_27/118000
    raise User::NotAuthorizedError unless user&.authenticate(params[:password])

    data = { user_id: user.id, email: user.email }
    # アクセストークンを作成(1日有効)
    # TODO: ゆくゆくはJWTの有効期限を短くして、リフレッシュトークンを発行するようにして下さい
    access_token = JWT.encode({ data: data, exp: Time.current.tomorrow.to_i }, 'secret')

    render json: { accessToken: access_token }, status: :ok
    # userが存在しない場合

    # 独自の例外を発生させる
  end
end
