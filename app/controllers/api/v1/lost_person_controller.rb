# TODO: コントローラー名は複数形にするのが一般的です（lost_people_controller.rb）
class Api::V1::LostPersonController < ApplicationController
  before_action :set_project
  before_action :set_lost_person, only: [:show,:update]

  # POST /api/v1/projects/:project_id/lost_person
  def create
    lost_person = @project.lost_people.create!(lost_person_params)
    render json: lost_person_response(lost_person), status: :created
  end

  # TODO: ここはcreateと同じ処理の中で、lost_person_imagesテーブルに保存するようにしてください
  def create_with_image
    lost_person = LostPerson.new(lost_person_params)
    lost_person_image = lost_person.lost_person_images.build(lost_person_image_params)
    lost_person_image.save!
    set_lost_person_image
    render json: lost_person_response(@lost_person), status: :created
  end

  # GET /api/v1/projects/:project_id/lost_person/:id
  def show
    render json: lost_person_response(@lost_person), status: :ok
  end

  # TODO: APIのエンドポイントのコメントを追加して下さい
  def index
    lost_people = LostPerson.includes(:client).all
    # response_success(lost_people)
    render json: lost_people, each_serializer: LostPersonSerializer
  end

  # TODO: APIのエンドポイントのコメントを追加して下さい
  def update
    return render_error_response('not_lost_person',:not_found) unless @lost_person

    if @lost_person.update!(lost_person_params)
      @lost_person.lost_person_images.each do |image|
        new_content = params.dig(:lost_person_image,:content)
        image.assign_attributes(content: new_content,updated_at: Time.current)
        image.save!
      end
      render json: lost_person_response(@lost_person), status: :ok
    end
  end


  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_lost_person
    @lost_person = @project.lost_people.find(params[:id])
  end

  def set_lost_person_image
    @lost_person_image = @project.lost_people.find(params[:id])
  end

  def lost_person_params
    params.require(:lost_person).permit(:name, :kana, :gender, :age, :tall, :reception_at, :status, :lost_storage_id, :project_id, :client_id)
  end

  def lost_person_image_params
    params.require(:lost_person_image).permit(:content, :lost_person_id)
  end

  # TODO: active_model_serializersを使用するようにして下さい(他の箇所も全部対応して下さい)
  # 参考: https://zenn.dev/emono/articles/8211ad5ec036e9
  def lost_person_response(lost_person)
    response = {
      id: lost_person.id,
      name: lost_person.name,
      kana: lost_person.kana,
      gender: lost_person.gender,
      age: lost_person.age,
      tall: lost_person.tall,
      reception_at: lost_person.reception_at,
      status: lost_person.status,
      project_id: lost_person.project_id,
      lost_storage_id: lost_person.lost_storage_id,
      created_at: lost_person.created_at,
      updated_at: lost_person.updated_at,
      client_id: lost_person.client_id,
      user_name: lost_person.client.name,
    }
    # TODO: ここもresponseに含めるようにして下さい（別の処理にしないでください）
    response[:content] = lost_person.lost_person_images.map { |image| { content: image.content } }

    # TODO: Rubyは最後の行の戻り値を返すので、returnは不要です
    response
  end
end
