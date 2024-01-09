# TODO: 不要なコメントは削除してください
class Api::V1::ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  # GET /api/v1/projects
  def index
    projects = Project.all
    render json: projects, each_serializer: ProjectSerializer
  end

  # GET /api/v1/projects/:id
  def show
    # TODO: ソースコードをリファクタリングしてください
    if @project&.delete_flg == false
      response_success(@project)
    end
  end

  # GET /api/v1/projects/search
  def search
    # TODO: エラー文が複数ある時は、複数返却できるようにして下さい
    if params[:name].blank? && params[:place].blank?
      error_message = I18n.t('response.message.blank_keywords')
      return response_custom_error(error_message, :bad_request)
    end

    if params[:name].present? && params[:name].length < 3
      error_message = I18n.t('response.message.name_too_short')
      return response_custom_error(error_message, :bad_request)
    end

    if params[:place].present? && params[:place].length < 3
      error_message = I18n.t('response.message.place_too_short')
      return response_custom_error(error_message, :bad_request)
    end

    # TODO: 部分一致は「%」を左右につけて下さい
    # TODO: ここ微妙なので、例を参考にしてリファクタリングして下さい
    # [例：]
    name_query = ""
    if params[:name].present?
      name_query = params[:name] + "%"
    end
    # name_query = params[:name].present? ?  params[:name] + "%" : nil
    place_query = params[:place].present? ?  params[:place] + "%" : nil

    # TODO: SQLインジェクション対策のため、where句には?を使って下さい(プレスホルダーの使用)
    # 参考: https://pikawaka.com/rails/where
    if name_query && place_query
      projects = Project.where("name LIKE ? AND place LIKE ?", name_query, place_query)
    else
      projects = Project.where("name LIKE ? OR place LIKE ?", name_query, place_query)
    end
    response_success(projects)
  end

  # POST /api/v1/projects
  def create
    # MEMO: こちらの方がいいと思います（処理は同じです）TODO: 不要なコメントは削除して下さい
    # TODO: ログインユーザーのIDを一緒に保存
    project = Project.create!(project_params)
    response_success(project)
  end

  # PATCH /api/v1/projects/:id
  def update
    if @project.update(project_params)
      response_success(@project)
    else
      error_message = if @project.errors.full_messages_for(:name).present? && @project.errors.full_messages_for(:place).present?
                I18n.t('response.message.both_blank')
              elsif @project.errors.full_messages_for(:name).present?
                I18n.t('response.message.name_blank')
              elsif @project.errors.full_messages_for(:place).present?
                I18n.t('response.message.place_blank')
              end
      render json: { error: error_message}, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/projects/:id
  def destroy
    if @project.update!(delete_flg: true, discarded_at: Time.current)
      render json: project_response(@project), status: :ok
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :start_at, :end_at, :place, :execution_date, :user_id, :delete_flg, :discarded_at)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def project_response(project)
    {name: project.name,
    user_id: project.user_id,
    created_at: project.created_at,
    updated_at: project.updated_at}
  end

end
