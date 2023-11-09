class Api::V1::ProjectsController < ApplicationController

  # サンプルAPI
  # /api/v1/projects
  def index
    projects = Project.all
    # render json: projects, status: :created
    render status: :ok, json: { status: 200, data: projects }
  end

end
