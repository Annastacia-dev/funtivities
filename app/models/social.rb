# == Schema Information
#
# Table name: socials
#
#  id              :uuid             not null, primary key
#  facebook        :string
#  instagram       :string
#  linkedin        :string
#  pinterest       :string
#  snapchat        :string
#  socialable_type :string           not null
#  telegram        :string
#  tiktok          :string
#  twitter         :string
#  website         :string
#  whatsapp        :string
#  youtube         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  socialable_id   :bigint           not null
#
# Indexes
#
#  index_socials_on_socialable  (socialable_type,socialable_id)
#
class Social < ApplicationRecord
end
