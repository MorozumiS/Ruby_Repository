class Api::V1::ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]
  # サンプルAPI
  # GET /api/v1/projects
  def index
    projects = Project.all
    render status: :ok, json: { status: 200, data: projects }
  end

  def create
    project = Project.new(project_params)
    if project.save
      response_success(project)
    else
      render_error("イベントの登録に失敗しました", :unprocessable_entity )
    end
  end

  def show
    if @project&.delete_flg == false
      response_success(@project)
    end
  end

  def search
    if params[:name].blank? && params[:place].blank?
      return render_error("検索キーワードが提供されていません", :bad_request)
    end

    if params[:name].present? && params[:name].length < 3
      return render_error("イベント名の文字数が不足しています", :bad_request)
    end

    if params[:place].present? && params[:place].length < 3
      return render_error("会場名の文字数が不足しています", :bad_request)
    end

    name_query = params[:name].present? ?  params[:name] + "%" : nil
    place_query = params[:place].present? ?  params[:place] + "%" : nil

    if name_query && place_query
      projects = Project.where("name LIKE ? AND place LIKE ?", name_query, place_query).compact
    else
      projects = Project.where("name LIKE ? OR place LIKE ?", name_query, place_query).compact
    end
    response_success(projects)
  end

  def update
    if @project.update(project_params)
      response_success(@project)
    else
      if @project.errors.full_messages_for(:name)
        error =  "会場名が空です"
      elsif @project.errors.full_messages_for(:place)
        error =  "場所名が空です"
      end
      render json: { error: error}, status: :unprocessable_entity
    end
  end

  def destroy
    if @project.update(delete_flg: true, discarded_at: Time.current)
      render json: project_response(@project), status: :ok
    else
      render_error("イベントの削除に失敗しました", :unprocessable_entity)
    end
  end


  private
  def project_params
    params.permit(:name, :start_at, :end_at, :place, :user_id, :created_at, :updated_at)
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
