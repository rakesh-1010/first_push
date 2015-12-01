class SweepstakePresenter
  
  def generate_secure_key
    secure_key = SecureRandom.hex(3) 
    until !(Sweepstake.exists?(:secure_key => secure_key)) do
      secure_key = SecureRandom.hex(3)
    end
    return secure_key
  end
end