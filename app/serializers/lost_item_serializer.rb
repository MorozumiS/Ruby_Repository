# == Schema Information
#
# Table name: lost_items
#
#  id              :bigint           not null, primary key
#  comment         :string(255)
#  discarded_at    :datetime
#  features        :string(255)
#  lost_spot       :string(255)      not null
#  name            :string(255)      not null
#  owner_address   :string(255)
#  owner_name      :string(255)
#  owner_tel       :string(255)
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
# == Schema Information
#
# Table name: lost_item_images
#
#  id           :bigint           not null, primary key
#  content      :string(255)      not null
#  discarded_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lost_item_id :bigint
#
# Indexes
#
#  index_lost_item_images_on_lost_item_id  (lost_item_id)
#
# Foreign Keys
#
#  fk_rails_...  (lost_item_id => lost_items.id)
#
class LostItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :comment, :features, :owner_name, :owner_tel, :owner_address, :lost_spot, :project_id,
            :lost_storage_id, :created_at, :updated_at, :content

  def content
    object.lost_item_images.map(&:content) if object.lost_item_images.present?
  end
end
