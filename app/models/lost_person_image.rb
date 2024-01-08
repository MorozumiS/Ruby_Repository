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
  # contentカラムのcreate/updateアクションのみを監視
  # TODO: これを参考に、discarded_atも同じようにcrete/updateのみを監視するように記述を追加して下さい
  # TODO: コメントの追加も必須にするように設定して下さい
  # TODO: また削除の際には、削除理由(comment)を必須にするように設定して下さい
  audited only: :content, on: %i[create update]
  belongs_to :lost_person

  validates :content, presence: true
end
