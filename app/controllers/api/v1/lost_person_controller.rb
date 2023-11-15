class Api::V1::LostPersonController < ApplicationController
  before_action :set_project
  before_action :set_lost_person, only: [:show]

  # POST /api/v1/projects/:project_id/lost_people
  def create
    lost_person = @project.lost_people.create!(lost_person_params)
    render json: lost_person_response(lost_person), status: :created
  end

  # GET /api/v1/projects/:project_id/lost_people/:id
  def show
    render json: lost_person_response(@lost_person)
  end

  # DELETE /api/v1/projects/:project_id/lost_people/:id
  def destroy

  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_lost_person
    @lost_person = @project.lost_people.find(params[:id])
  end

  def lost_person_params
    params.require(:lost_person).permit(:name, :kana, :gender, :age, :tall, :reception_at, :status, :lost_storage_id, :project_id)
  end

  def lost_person_response(lost_person)
    {
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
      updated_at: lost_person.updated_at
    }
  end
end
