# == Schema Information
#
# Table name: lost_items
#
#  id              :bigint           not null, primary key
#  comment         :string(255)
#  discarded_at    :datetime
#  features        :string(255)
#  name            :string(255)      not null
#  owner_address   :string(255)
#  owner_name      :string(255)
#  owner_tel       :string(255)
#  place           :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  lost_storage_id :bigint
#  project_id      :bigint
#
# Indexes
#
#  index_lost_items_on_lost_storage_id  (lost_storage_id)
#  index_lost_items_on_project_id       (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (lost_storage_id => lost_storages.id)
#  fk_rails_...  (project_id => projects.id)
#
class LostItem < ApplicationRecord
  validates :name, :place, presence: true
end
