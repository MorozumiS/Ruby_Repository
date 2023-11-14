class LostItemsController < ApplicationController
  before_action :set_lost_item, only: [:show, :destroy]

  # POST /lost_items
  def create
    lost_item = LostItem.new(lost_item_params)

    lost_item.save!
      render json: lost_item_response(lost_item), status: :created
    end
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
      :name, :lost_spot, :comment, :owner_name, :owner_tel, :owner_address,
      :features, :project_id, :lost_storage_id, :lost_item_image_id
    )
  end

  def lost_item_response(lost_item)
    {
      id: lost_item.id,
      name: lost_item.name,
      comment: lost_item.comment,
      owner_name: lost_item.owner_name,
      owner_tel: lost_item.owner_tel,
      owner_address: lost_item.owner_address,
      place: lost_item.place,
      project_id: lost_item.project_id,
      lost_storage_id: lost_item.lost_storage_id,
      lost_item_image_id: lost_item.lost_item_image_id,
    }
  end
end
