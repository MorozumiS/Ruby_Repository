class Api::V1::LostItemsController < ApplicationController
  before_action :set_lost_item, only: [:show, :destroy]

  # POST /lost_items
  def create
    lost_item = LostItem.create!(lost_item_params)
    render json: lost_item_response(lost_item), status: :created
  end

  def create_with_image
    lost_item = LostItem.new(lost_item_params)
    lost_item_image = lost_item.lost_item_images.build(lost_item_image_params)
    lost_item_image.save!
    render json: lost_item_response(lost_item), status: :created
  end

  def index
    lost_items = LostItem.all
    response_success(lost_items)
  end
  # GET /lost_items/:id
  def show
    render json: lost_item_response(@lost_item)
  end

  # DELETE /lost_items/:id
  def destroy

  end

  private

  def set_lost_item
    @lost_item = LostItem.find(params[:id])
  end

  def lost_item_params
    params.require(:lost_item).permit(
      :name, :lost_spot, :comment, :features, :owner_name, :owner_tel, :owner_address,
      :project_id, :lost_storage_id
    )
  end

  def lost_item_image_params
    params.require(:lost_item_image).permit(:lost_item_id, :content )
  end

  def lost_item_response(lost_item)
    response = {
      id: lost_item.id,
      name: lost_item.name,
      comment: lost_item.comment,
      features: lost_item.features,
      owner_name: lost_item.owner_name,
      owner_tel: lost_item.owner_tel,
      owner_address: lost_item.owner_address,
      lost_spot: lost_item.lost_spot,
      project_id: lost_item.project_id,
      lost_storage_id: lost_item.lost_storage_id,
      created_at: lost_item.created_at,
      updated_at: lost_item.updated_at
    }

    if lost_item.lost_item_image.present?
      lost_item_image = lost_item.lost_item_image.first
      response[:content] = lost_item_image.content
    else
      response[:content] = nil
    end
    response
  end
end
