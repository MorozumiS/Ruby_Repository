class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  def create
    project = Project.new(project_params)
    if project.save
      render json: project, status: :created
    else
      render json:  { error: "イベントの登録に失敗しました" }, status: :unprocessable_entity
    end
  end

  def show
    if @project && !@project.delete_flg
      render json: @project, status: :ok
    else
      render json: { error: "イベントが存在しません" }, status: :not_found
    end
  end

  def name_search
    if params[:name].blank?
      return render json: { error: "検索キーワードが提供されていません" }, status: :bad_request
    elsif params[:name].length < 3
      return render json: { error: "文字数が不足しています" }, status: :bad_request
    end

    name_query = params[:name] + "%"
    projects = Project.where("name LIKE ?",name_query)
    if projects.blank?
      render json: { error: "イベントが存在しません" }, status: :not_found
    else
      render json: projects, status: :ok
    end
  end


  def update
    if @project.nil?
      render json: { error: "イベントが存在しません" }, status: :not_found
    else
      if @project.update(project_params)
        render json: @project, status: :ok
      else
        if @project.errors.full_messages_for(:name)
          error =  "会場名が空です"
        elsif @project.errors.full_messages_for(:place)
          error =  "場所名が空です"
        end
        render json: { error: error}, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @project.update(delete_flg: true, discarded_at: Time.current)
      render json: project_response(@project), status: :ok
    else
      render json: { error: "イベントの削除に失敗しました" }, status: :unprocessable_entity
    end
  end


  private
  def project_params
    params.permit(:name, :start_at, :end_at, :place, :user_id, :created_at, :updated_at)
  end

  def set_project
    @project = Project.find_by(id: params[:id])
    if @project.nil?
      render json: { error: "イベントが存在しません" }, status: :not_found
    end
  end

  def project_response(project)
    {name: project.name,
    user_id: project.user_id,
    created_at: project.created_at,
    updated_at: project.updated_at}
  end
end
