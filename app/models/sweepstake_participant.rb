class SweepstakeParticipant < ActiveRecord::Base

  belongs_to :sweepstake
  belongs_to :participant

end
