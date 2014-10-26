class App < Sinatra::Base

	get '/api/user/:id', :provides => :json do
		content_type :json
		
		if params[:content]
			user = User.first(:id => params[:id]) 
			user.to_json
		else
			json_status 404, "Not found"
		end		
			
		
	end




end


 # $.ajax({
 #          url:'https://api.github.com/users/' + profile_name + '?client_id=b2c964564828b30bce0a&client_secret=d046cb64116bcf75714bc493794c3c176178eb9b',
 #          type: 'GET',
 #          dataType: 'json',
 #          success: function(gitHubProfile) {
 #            $('#profiles').append(template(gitHubProfile)),
 #            $('#profile_name').val('');
 #          },
 #          error: function() { alert("Profile not found!"); } 
 #        });