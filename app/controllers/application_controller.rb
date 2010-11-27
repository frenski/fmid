class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def gen_form
    @entry = Entry.new
  end 
  
end
