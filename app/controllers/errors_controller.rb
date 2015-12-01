class ErrorsController < ApplicationController
  layout 'error'
  
  def show
    puts "===============#{request.path[1..-1]}==============="
    render action: request.path[1..-1]
  end

end
