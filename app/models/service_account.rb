class ServiceAccount < ActiveRecord::Base
  belongs_to :user
end



# == Schema Information
#
# Table name: service_accounts
#
#  id         :integer(4)      not null, primary key
#  service    :string(255)
#  login      :string(255)
#  password   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer(4)
#

