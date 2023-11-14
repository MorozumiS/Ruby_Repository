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

  validates :name, presence: true

  before_destroy :check_reception_number_prefix

  private

  def check_reception_number_prefix
    if reception_number_prefix.present? && reception_number_prefix_changed?
      errors.add(:reception_number_prefix, 'この値は変更/削除できません')
      throw(:abort)
    end
  end
end
