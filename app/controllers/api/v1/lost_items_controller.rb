class Api::V1::LostItemsController < ApplicationController
  before_action :set_lost_item, only: %i[show destroy]

  # POST /api/v1/lost_items
  def create
    ActiveRecord::Base.transaction do
      lost_item = LostItem.new(lost_item_params)
      lost_item.lost_item_images.build(lost_item_image_params)

      if lost_item.save
        render json: lost_item, serializer: LostItemSerializer
      else
        render json: { error: lost_item.errors.full_messages.join(', ') }, status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end
    end
  end

  # GET /api/v1/lost_items
  def index
    lost_items = LostItem.all
    response_success(lost_items)
  end

  # GET /api/v1/lost_items/:id
  def show
    render json: @lost_item, serializer: LostItemSerializer
  end

  # DELETE /api/v1/lost_items/:id
  def destroy
    set_lost_item
    if !@lost_item
      render_error_response('not_item', :not_found)
    elsif !@lost_item.project_id
      render_error_response('not_project', :not_found)
    elsif !@lost_item.lost_storage_id
      render_error_response('not_storage', :not_found)
    elsif @lost_item.update!(discarded_at: Time.current) && @lost_item.lost_item_images.update_all(discarded_at: Time.current)
      @lost_item.lost_item_images.each do |image|
        image.update!(discarded_at: Time.current)
      end
      render json: lost_item_response_destroy(@lost_item), status: :ok
    end
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
    params.require(:lost_item_image).permit(:lost_item_id, :content)
  end

  def lost_item_response_destroy(lost_item)
    render json: lost_item, serializer: LostItemSerializer,
    only: [:id :name :project_id :lost_storage_id :created_at :updated_at :discarded_at]
  end

  def render_error_response(message_key, status)
    message = I18n.t("response.message.#{message_key}")
    render json: { error: message }, status: status
  end
end
