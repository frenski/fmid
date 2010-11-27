class FlickrController < ApplicationController
  
    #url = "http://api.flickr.com/services/rest/?&method=flickr.urls.lookupUser&api_key=7c0d079bcc8d0bcfdc68b126fb0fb4d8&url=http://www.flickr.com/photos/mexicanrejectdafe/&format=json"
  
  @@api_url = "http://api.flickr.com/services/rest/?&method=flickr.urls.lookupUser"
  @@api_key = "7c0d079bcc8d0bcfdc68b126fb0fb4d8"
  @@api_format = "json"
  
  def index
    gen_form
  end
  
  def create
    params[:entry][:ip] = request.remote_ip
    @entry = Entry.new(params[:entry])
    
    #flickr_name = params[:entry][:socid].match(/photos\/([^&]*)/)
    
    if(params[:entry][:socid])
      flickr_url = @@api_url+'&api_key='+@@api_key+'&url='+params[:entry][:socid]+'&format='+@@api_format
      content = Net::HTTP.get(URI.parse(flickr_url)).match(/\{([^&]*[^\)])/)
      json_obj = ActiveSupport::JSON.decode(content[0])
      
      if(json_obj['user']['id'])
        flickr_id = json_obj['user']['id']
        
        if(flickr_id && @entry.save)
          @result = 'Here is your id: '+flickr_id
        else
          @result = 'There was an error processing your request'
        end
        
      else
        @result = "Your Flickr user doesn't exist or it's wrong (It should be in format: http://www.flickr.com/photos/username/)"
      end
      
    else
      @result = "Please enter a Flickr photstream url!"
    end
    
    respond_to do |format| 
      format.html {render :layout => false}
      format.xml { render :xml => @entry } 
    end
    
  end

end
