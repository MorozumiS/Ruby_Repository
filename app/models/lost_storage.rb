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
  MAX_NUMBER = 6

  has_many :projects
  validates :name, presence: true

  def self.generate_reception_number_prefix(project)
    last_prefix = where(project_id: project.id).maximum(:reception_number_prefix)

    if last_prefix
      last_letter, last_number = last_prefix.to_s.match(/^([A-Z]+)(\d*)$/).captures
      new_number = last_number.empty? ? 1 : last_number.to_i + 1
      new_letter = new_number > MAX_NUMBER ? last_letter.next : last_letter
      new_number = 1 if new_number > MAX_NUMBER
    else
      new_number = 1
      new_letter = ''
    end

    "#{new_letter}#{format('%05d', new_number)}"
  end

  def self.project_code(project)
    project.name[0].upcase
  end
end
