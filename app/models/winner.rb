class Winner < ActiveRecord::Base
  belongs_to :participant
  belongs_to :sweepstake
  belongs_to :admin_user
end
