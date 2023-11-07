class ProjectsController < ApplicationController
  def create
    project = Project.new(project_params)

    if project.save
      render json: project, status: :created
    else
      render json:  { error: "イベントの登録に失敗しました" }, status: :unprocessable_entity
    end
  end

  def show
    project = Project.find_by(id: params[:id])
    if project
      render json: project, status: :ok
    else
      render json: { error: "イベントが存在しません" }, status: :not_found
    end
  end

  private

  def project_params
    params.permit(:name, :start_at, :end_at, :place, :client_id, :created_at, :updated_at)
  end
end
