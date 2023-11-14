class LostItemImagesController < ApplicationController
  before_action :set_lost_item_image, only: [:show, :destroy]

  # POST /lost_item_images
  def create
    lost_item_image = LostItemImage.new(lost_item_image_params)

    lost_item_image.save!
      render json: lost_item_image_response(lost_item_image), status: :created
    end
  end

  # GET /lost_item_images/:id
  def show
    render json: lost_item_image_response(@lost_item_image)
  end

  # DELETE /lost_item_images/:id
  def destroy

  end

  private

  def set_lost_item_image
    @lost_item_image = LostItemImage.find(params[:id])
  end

  def lost_item_image_params
    params.require(:lost_item_image).permit(:image)
  end

  def lost_item_image_response(lost_item_image)
    {
      id: lost_item_image.id,
      image_url: lost_item_image.image.url,
      created_at: lost_item_image.created_at,
      updated_at: lost_item_image.updated_at
    }
  end
end
