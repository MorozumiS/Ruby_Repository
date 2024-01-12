# TODO: そもそもこのコントローラーは必要ないです APIないですし削除お願いします

class Api::V1::LostPersonImagesController < ApplicationController
  before_action :set_lost_person_image, only: [:show]

  # POST /api/v1/projects/:project_id/lost_person_image
  def create
    lost_person_image = LostPersonImage.create!(lost_person_image_params)
    render json: lost_person_image_response(lost_person_image), status: :created
  end

  # GET /api/v1/projects/:project_id/lost_person_image/:id
  def show
    render json: lost_person_image_response(@lost_person_image)
  end

  def index
    lost_person_image = LostPersonImage.all
    response_success(lost_person_image)
  end

  # DELETE /api/v1/projects/:project_id/lost_person_image/:id
  def destroy; end

  private

  def set_lost_person_image
    @lost_person_image = LostPersonImage.find(params[:id])
  end

  def lost_person_image_params
    params.require(:lost_person_image).permit(:content, :lost_person_id)
  end

  def lost_person_image_response(lost_person_image)
    {
      id: lost_person_image.id,
      content: lost_person_image.content,
      created_at: lost_person_image.created_at,
      updated_at: lost_person_image.updated_at,
      lost_person_id: lost_person_image.lost_person_id
    }
  end
end
