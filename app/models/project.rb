# == Schema Information
#
# Table name: projects
#
#  id           :bigint           not null, primary key
#  delete_flg   :boolean          default(FALSE), not null
#  discarded_at :datetime
#  end_at       :datetime
#  name         :string(255)      not null
#  place        :string(255)      not null
#  start_at     :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
# Indexes
#
#  index_projects_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Project < ApplicationRecord
  has_many :users
  has_many :lost_storages

  validates :name, :place , presence: true
end
