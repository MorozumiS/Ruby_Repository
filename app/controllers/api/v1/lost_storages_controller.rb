class Api::V1::LostStoragesController < ApplicationController
  before_action :set_project
  before_action :set_lost_storage, only: [:show]

  MAX_NUMBER = 6

  # POST /api/v1/projects/:project_id/lost_storages
  def create
    lost_storage = @project.lost_storages.build(lost_storage_params)
    lost_storage.reception_number_prefix = generate_reception_number_prefix

    lost_storage.save!
      render json: lost_storage_response(lost_storage), status: :created
    end
  end

  # GET /api/v1/projects/:project_id/lost_storages/:id
  def show
    render json: lost_storage_response(@lost_storage)
  end

  # GET /api/v1/projects/:project_id/lost_storages/
  def index
    lostStorage = LostStorage.all
    render status: :ok, json: { status: 200, data: lostStorage }
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_lost_storage
    @lost_storage = @project.lost_storages.find(params[:id])
  end

  def lost_storage_params
    params.require(:lost_storages).permit(:name)
  end

  def generate_reception_number_prefix
    last_prefix = LostStorage.where(project_id: @project.id).maximum(:reception_number_prefix)

    if last_prefix
      last_letter, last_number = last_prefix.to_s.match(/^([A-Z]+)(\d*)$/).captures
      new_number = last_number.empty? ? 1 : last_number.to_i + 1
      new_letter = new_number > MAX_NUMBER ? last_letter.next : last_letter
      new_number = 1 if new_number > MAX_NUMBER
    else
      new_number = 1
      new_letter = ''
    end

    "#{new_letter}#{format('%05d', new_number)}"
  end

  def project_code(project)
    project.name[0].upcase
  end

  def lost_storage_response(lost_storage)
    {
      id: lost_storage.id,
      name: lost_storage.name,
      reception_number_prefix: lost_storage.reception_number_prefix,
      project_id: lost_storage.project_id,
      created_at: lost_storage.created_at,
      updated_at: lost_storage.updated_at
    }
  end
end
