# == Schema Information
#
# Table name: lost_storages
#
#  id                      :bigint           not null, primary key
#  name                    :string(255)      not null
#  reception_number_prefix :string(255)      not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  project_id              :bigint
#
# Indexes
#
#  index_lost_storages_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
class LostStorage < ApplicationRecord
  has_many :projects

  validates :name, presence: true
end
