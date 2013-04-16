class HomeController < ActionController::Base
  APP_ID = 'something real'
  APP_SECRET = 'something real'
  SITE_URL = 'http://localhost:3000'

  protect_from_forgery
  
   def index   
    session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/home/callback')
    @auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"read_stream")  
    puts session.to_s + "<<< session"

    respond_to do |format|
       format.html {  }
     end
  end

  def callback
    if params[:code]
      # acknowledge code and get access token from FB
      session[:access_token] = session[:oauth].get_access_token(params[:code])
    end   

     # auth established, now do a graph call:

    @api = Koala::Facebook::API.new(session[:access_token])
    begin
      @graph_data = @api.get_object("/me/statuses", "fields"=>"message")
    rescue Exception=>ex
      puts ex.message
    end

  
    respond_to do |format|
     format.html {   }       
    end


  end
end