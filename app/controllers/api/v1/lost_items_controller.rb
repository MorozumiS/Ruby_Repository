class Api::V1::LostItemsController < ApplicationController
  before_action :set_lost_item, only: %i[show destroy]

  # POST /lost_items
  def create
    lost_item = LostItem.create!(lost_item_params)
    render json: lost_item_response(lost_item), status: :created
  end

  # TODO: ここはcreateと同じ処理の中で、lost_item_imagesテーブルに保存するようにしてください
  def create_with_image
    lost_item = LostItem.new(lost_item_params)

    return unless lost_item.save!

    lost_item_id = lost_item.id
    lost_item_image = LostItemImage.new(lost_item_image_params.merge(lost_item_id: lost_item_id))
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

  # TODO: 書き方がおかしいので修正する＆active_model_serializersを使用するようにして下さい
  def lost_item_response_destroy(lost_item)
    { id: lost_item.id,
      name: lost_item.name,
      project_id: lost_item.project_id,
      lost_storage_id: lost_item.lost_storage_id,
      created_at: lost_item.created_at,
      updated_at: lost_item.updated_at,
      discarded_at: lost_item.discarded_at }
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

    response[:content] = (lost_item.lost_item_images.map(&:content) if lost_item.lost_item_images.present?)
    response
  end

  def render_error_response(message_key, status)
    message = I18n.t("response.message.#{message_key}")
    render json: { error: message }, status: status
  end
end
