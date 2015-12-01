# require 'clockwork'
require 'clockwork'
require './config/boot'
require './config/environment'


module Clockwork
  
  handler do |job|
    puts "Running #{job} =================================="
  end

  puts "Checking Sweepstake Active/ Deactivate !"
  every(1.day, 'sweepstake_status') {
    `rake active_sweepstake:sweepstake_status_active`
  }

  every(1.day, 'sweepstake_status', :at => '23:55') {
    `rake active_sweepstake:sweepstake_status_active`
  }
end

