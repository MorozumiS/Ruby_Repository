# == Schema Information
#
# Table name: lost_people
#
#  id              :bigint           not null, primary key
#  age             :string(255)      not null
#  discarded_at    :datetime
#  gender          :integer          not null
#  kana            :string(255)      not null
#  last_sign_in_at :datetime
#  name            :string(255)      not null
#  reception_at    :datetime
#  status          :integer          not null
#  tall            :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  lost_storage_id :bigint
#  project_id      :bigint
#
# Indexes
#
#  index_lost_people_on_lost_storage_id  (lost_storage_id)
#  index_lost_people_on_project_id       (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (lost_storage_id => lost_storages.id)
#  fk_rails_...  (project_id => projects.id)
#
class LostPerson < ApplicationRecord

  belongs_to :lost_storage

  validates :name, :kana, :gender, :age, :tall, :reception_at, :status, presence: true

end
