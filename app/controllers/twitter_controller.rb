class TwitterController < ApplicationController
  
  @@data_url = "http://api.twitter.com/1/users/show/"
  @@data_type = "xml"
  require 'open-uri'
  
  def index
    gen_form
  end
  
  def create
    params[:entry][:ip] = request.remote_ip
    @entry = Entry.new(params[:entry])
    
    tw_name = params[:entry][:socid].match(/com\/#!\/([^&]*)/)
    
    if(tw_name)
      tw_url = @@data_url+tw_name[1]+'.'+@@data_type
     # tw_url = open(tw_url)

     begin
       open tw_url
     rescue
       @result = "Wrong url or name!"
     else
      tw_xml = Nokogiri::XML.parse(open(tw_url))
      unless(tw_xml.nil?)
        tw_id = tw_xml.root.children[1].content
        
        if(tw_id && @entry.save)
          @result = 'Here is your id:'+tw_id
        else
          @result = 'There was an error processing your request'
        end
        
      else
        @result = "Your twitter profile doesn't exist or it's wrong (It should be in format: http://twitter.com/#!/UN)"
      end
    end
      
    else
      @result = "Please enter a Twitter profile url!"
    end
    
    #TODO: fix the shitty code
    
    respond_to do |format| 
      format.html {render :layout => false}
      format.xml { render :xml => @entry } 
    end
    
  end

end
