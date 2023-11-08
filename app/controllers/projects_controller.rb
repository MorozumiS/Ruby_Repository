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
    if @project
      render json: @project, status: :ok
    else
      render json: { error: "イベントが存在しません" }, status: :not_found
    end
  end

  def name_search
    @project = Project.find_by(name: params[:name])
    if @project
      render json: @project, status: :ok
    else
      render json: { error: "イベントが存在しません" }, status: :not_found
    end
  end

  def update
    if @project.update(project_params)
      render json: @project, status: :ok
    else
      render json: { error: "イベントの更新に失敗しました" }, status: :unprocessable_entity
    end
  end

  def destroy
    if @project.update(discarded_at: Time.current)
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
