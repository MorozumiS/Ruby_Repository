# == Schema Information
#
# Table name: users
#
#  id                    :bigint           not null, primary key
#  discarded_at          :datetime
#  email                 :string(255)      not null
#  kana                  :string(255)      not null
#  last_sign_in_at       :datetime
#  name                  :string(255)      not null
#  password              :string(255)      not null
#  password_confirmation :string(255)      not null
#  role                  :integer          not null
#  tel                   :string(255)      not null
#  uid                   :string(255)      default(""), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_many :projects

  # TODO: 後に追加する
  # validates :name, :role ,:uid, presence: true
  # validates :email, presence: true, uniqueness: true
  # validates :kana, presence: true, format: {with: /\A[\p{Hiragana} 　]+\z/, message: I18n.t("errors.models.user.not_hiragana")}
  # validates :tel, format: {with: /\A0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1})[-)]?\d{4}\z|\A0[5789]0[-]?\d{4}[-]?\d{4}\z/, message: I18n.t("errors.models.user.not_tel_format")}, uniqueness: true, presence: true
end
