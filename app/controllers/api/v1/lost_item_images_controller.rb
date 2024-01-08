class Api::V1::LostItemImagesController < ApplicationController
  before_action :set_lost_item_image, only: %i[show destroy]

  # POST /lost_item_images
  def create
    lost_item_image = LostItemImage.create!(lost_item_image_params)
    render json: lost_item_image_response(lost_item_image), status: :created
  end

  # GET /lost_item_images/:id
  def show
    render json: lost_item_image_response(@lost_item_image)
  end

  # DELETE /lost_item_images/:id
  def destroy; end

  private

  def set_lost_item_image
    @lost_item_image = LostItemImage.find(params[:id])
  end

  def lost_item_image_params
    params.require(:lost_item_image).permit(:content, :lost_item_id)
  end

  def lost_item_image_response(lost_item_image)
    {
      content: lost_item_image.content,
      lost_item_id: lost_item_image.lost_item_id,
      created_at: lost_item_image.created_at,
      updated_at: lost_item_image.updated_at,
      discarded_at: lost_item_image.discarded_at
    }
  end
end
