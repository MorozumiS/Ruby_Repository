class Api::V1::ProjectsController < ApplicationController
  before_action :set_project, only: %i[show update destroy]

  # GET /api/v1/projects
  def index
    projects = Project.all
    render json: projects, each_serializer: ProjectSerializer
  end

  # GET /api/v1/projects/:id
  def show
    render json: (project if @project&.delete_flg == false), serializer: ProjectSerializer
  end

  # GET /api/v1/projects/search
  def search
    error_messages = []

    error_messages << I18n.t('response.message.blank_keywords') if params[:name].blank? && params[:place].blank?
    error_messages << I18n.t('response.message.name_too_short') if params[:name].present? && params[:name].length < 2
    error_messages << I18n.t('response.message.place_too_short') if params[:place].present? && params[:place].length < 2

    return response_custom_error(error_messages, :bad_request) if error_messages.any?

    name_query = params[:name].present? ? '%' + params[:name] + '%' : ''
    place_query = params[:place].present? ? '%' + params[:place] + '%' : ''

    projects = if name_query.present? && place_query.present?
                Project.where('name LIKE ? AND place LIKE ?', name_query, place_query)
              else
                Project.where('name LIKE ? OR place LIKE ?', name_query, place_query)
              end
    response_success(projects)
  end

  # POST /api/v1/projects
  def create
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
      render json: { error: error_message }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/projects/:id
  def destroy
    return unless @project.update!(delete_flg: true, discarded_at: Time.current)
    render json: @project, serializer: ProjectSerializer
  end

  private

  def project_params
    params.require(:project).permit(:name, :start_at, :end_at, :place, :execution_date, :user_id, :delete_flg,
                                    :discarded_at)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
