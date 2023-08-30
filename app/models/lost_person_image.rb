# == Schema Information
#
# Table name: lost_person_images
#
#  id             :bigint           not null, primary key
#  content        :string(255)      not null
#  discarded_at   :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  lost_person_id :bigint
#
# Indexes
#
#  index_lost_person_images_on_lost_person_id  (lost_person_id)
#
# Foreign Keys
#
#  fk_rails_...  (lost_person_id => lost_people.id)
#
class LostPersonImage < ApplicationRecord
end
