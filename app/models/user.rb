# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  discarded_at    :datetime
#  email           :string(255)      not null
#  kana            :string(255)      not null
#  last_sign_in_at :datetime
#  name            :string(255)      not null
#  password_digest :string(255)
#  role            :integer          not null
#  tel             :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  # 全てのカラム・アクションを監視
  audited

  # passwordをハッシュ化して保存する
  has_secure_password

  has_many :projects
  has_many :lost_people, foreign_key: 'client_id'

  validates :name, :email, presence: true
  validates :email, :tel, uniqueness: true
  # TODO: 後に追加する
  # validates :name, :role ,:uid, presence: true
  # validates :email, presence: true, uniqueness: true
  # validates :kana, presence: true, format: {with: /\A[\p{Hiragana} 　]+\z/, message: I18n.t("errors.models.user.not_hiragana")}
  # validates :tel, format: {with: /\A0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1})[-)]?\d{4}\z|\A0[5789]0[-]?\d{4}[-]?\d{4}\z/, message: I18n.t("errors.models.user.not_tel_format")}, uniqueness: true, presence: true
end
