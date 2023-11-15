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
class LostItemImage < ApplicationRecord
  validates :lost_item_id, :content, presence: true
end
