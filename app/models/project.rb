# == Schema Information
#
# Table name: projects
#
#  id             :bigint           not null, primary key
#  delete_flg     :boolean          default(FALSE), not null
#  discarded_at   :datetime
#  end_at         :datetime
#  execution_date :date
#  name           :string(255)      not null
#  place          :string(255)      not null
#  start_at       :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
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
  # 全てのカラム・アクションを監視
  audited

  has_many :users
  has_many :lost_people

  validates :name, :place, presence: true

  # TODO: scopeを使って、削除済みのイベントを除外する
  scope :no_discarded, -> { where(discarded_at: nil) }

  # TODO: scopeを使って管理者かどうかを判定して、管理者のみプロジェクトを作成・更新・削除できるようにする
  scope :admin_only, -> { joins(:users).where(users: { admin: true }) }
end
