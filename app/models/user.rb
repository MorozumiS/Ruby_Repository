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
#  role            :integer          not null
#  tel             :string(255)      not null
#  uid             :string(255)      default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
end
