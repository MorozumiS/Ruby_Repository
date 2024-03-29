class Api::V1::LostPeopleController < ApplicationController
  before_action :set_project
  before_action :set_lost_person, only: %i[show update]

  # TODO: API叩いたらエラーが出たので、修正して下さい
  # POST /api/v1/projects/:project_id/lost_people
  def create
    ActiveRecord::Base.transaction do
      lost_person = LostPerson.new(lost_person_params)
      lost_person.lost_person_images.build(lost_person_image_params)

      if lost_person.save
        render json: lost_person, each_serializer: LostPersonSerializer
      else
        # TODO: 文字列結合は、+ではなく、#{}記法を使って下さい
        render json: { error: (lost_person.errors.full_messages + lost_person.lost_person_images.first.errors.full_messages).join(', ') }, status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end
    end
  end

  # TODO: API叩いたらエラーが出たので、修正して下さい
  # GET /api/v1/projects/:project_id/lost_people/:id
  def show
    render json: @lost_person, each_serializer: LostPersonSerializer
  end

  # GET /api/v1/projects/:project_id/lost_people
  def index
    lost_people = LostPerson.includes(:client).all
    render json: lost_people, each_serializer: LostPersonSerializer
  end

  # PATCH  /api/v1/projects/:project_id/lost_people/:id
  def update
    # TODO: これってなんのために、書いていますか？
    # return render_error_response('not_lost_person', :not_found) unless @lost_person

    # TODO: これって必要でしょうか？
    return unless @lost_person.update!(lost_person_params)
    # TODO: ここもトランザクションを使用して下さい
    @lost_person.lost_person_images.each do |image|
      new_content = params.dig(:lost_person_image, :content)
      image.assign_attributes(content: new_content, updated_at: Time.current)
      image.save!
    end
    render json: lost_person_response(@lost_person), status: :ok
  end

  private

  # TODO: 他のコントローラーにもあるので共通化して下さい
  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_lost_person
    @lost_person = @project.lost_people.find(params[:id])
  end

  def set_lost_person_image
    @lost_person_image = @project.lost_people.find(params[:id])
  end

  # TODO: ストロングパラメーターは複数あるならまとめて下さい(諸事情により一旦飛ばしでOKです)
  def lost_person_params
    params.require(:lost_person).permit(:name, :kana, :gender, :age, :tall, :reception_at, :status, :lost_storage_id,
                                        :project_id, :client_id)
  end

  def lost_person_image_params
    params.require(:lost_person_image).permit(:content, :lost_person_id)
  end
end
