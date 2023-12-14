class Api::V1::LostPersonController < ApplicationController
  before_action :set_project
  before_action :set_lost_person, only: [:show,:update]

  # POST /api/v1/projects/:project_id/lost_person
  def create
    lost_person = @project.lost_people.create!(lost_person_params)
    render json: lost_person_response(lost_person), status: :created
  end

  def create_with_image
    lost_person = LostPerson.new(lost_person_params)
    lost_person_image = lost_person.lost_person_images.build(lost_person_image_params)
    lost_person_image.save!
    set_lost_person_image
    render json: lost_person_response(lost_person,@lost_person_image), status: :created
  end

  # GET /api/v1/projects/:project_id/lost_person/:id
  def show
    render json: lost_person_response(@lost_person,@lost_person_image), status: :ok
  end

  def index
    lost_people = LostPerson.includes(:client).all
    response_success(lost_people)
  end

  def update
    return render_error_response('not_lost_person',:not_found) unless @lost_person

    if @lost_person.update!(lost_person_params)
      @lost_person.lost_person_images.each do |image|
        new_content = params.dig(:lost_person_image,:content)  # params から content を取得
      image.assign_attributes(content: new_content,updated_at: Time.current)
      image.save!
      end
      puts @lost_person.errors.full_messages
      render json: lost_person_response(@lost_person, @lost_person.lost_person_images), status: :ok
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

  def render_error_response(message_key, status)
    message = I18n.t("response.message.#{message_key}")
    render json: { error: message }, status: status
  end

  def lost_person_response(lost_person,lost_person_image)
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
      user_name: lost_person.client&.name,
    }

    lost_person_images = lost_person.lost_person_images.map { |image| { content: image.content } }
    response[:content] = lost_person_images

    response
  end
end
