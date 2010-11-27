class FacebookController < ApplicationController
  
  @@fb_url = "http://graph.facebook.com/"
  
  def index
    gen_form
  end
  
  def create
    params[:entry][:ip] = request.remote_ip
    @entry = Entry.new(params[:entry])
    
    fb_name = params[:entry][:socid].match(/facebook.com\/([^&]*)/)
    
    if(fb_name)
      graph_url = @@fb_url+fb_name[1]
      content = Net::HTTP.get(URI.parse(graph_url))
      graph_obj = ActiveSupport::JSON.decode(content)
      
      if(graph_obj['error'].nil?)
        fb_id = graph_obj['id']
        
        if(fb_id && @entry.save)
          @result = 'Here is your id: '+fb_id
        else
          @result = 'There was an error processing your request'
        end
        
      else
        @result = "Your facebook profile/page doesn't exist or it's wrong (It should be in format: http://www.facebook.com/markzuckerberg)"
      end
      
    else
      @result = "Please enter a Facebook profile page url!"
    end
    
    respond_to do |format| 
      format.html {render :layout => false}
      format.xml { render :xml => @entry } 
    end 
    
  end

end
