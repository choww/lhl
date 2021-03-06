get '/' do
  logged_in = session[:user_id] 
  @current_user = User.find(logged_in) if logged_in
  session[:votes] ||= []
  @songs = Song.all
  erb :index
end

get '/signup' do
  @user = User.new
  erb :'users/new'
end

post '/' do
  @user = User.new(
    name: params[:name],
    password: params[:password]
  )
  if @user.save
    redirect '/'
  else
    erb :'users/new'
  end
end

get '/login' do
  @user = User.new
  erb :login
end

post '/login' do
  @user = User.where(name: params[:name], password: params[:password]).first
  if @user
    session[:user_id] = @user.id
    redirect '/'
  else
    @error = "Wrong name/password combination"
    erb :login
  end
end

get '/logout' do
  session[:user_id] = nil
  session[:votes] = nil
  redirect '/'
end

get '/new-song' do
  @user = User.find(session[:user_id])
  @song = @user.songs.new 
  erb :'songs/new' 
end 
 
post '/new-song' do 
  @user = User.find(session[:user_id])
  @song = @user.songs.new(params[:song]) 
  if @song.save 
    redirect '/'  
  else 
    erb :'songs/new' 
  end 
end

get '/song-:id' do
  logged_in = session[:user_id]
  @current_user = User.find(logged_in) if logged_in
  
  @song = Song.find(params[:id])
  user = User.find(@song.user.id)
  @more_songs = user.songs.where.not(id: @song.id)

  @review = Review.new
  erb :'songs/show'
end 

post '/song-:id' do
  logged_in = session[:user_id]
  @current_user = User.find(logged_in) if logged_in
  @song = Song.find(params[:id])
  user = User.find(@song.user.id)
  @more_songs = user.songs.where.not(id: @song.id)

  @review = Review.new(
    user_id: @current_user.id,
    song_id: params[:id],
    rating: params[:rating].to_i,
    content: params[:content]
  )
  if @review.save
    redirect "/song-#{@song.id}"
  else
    erb :'songs/show'
  end
end

get '/edit/song-:id' do
  @song = Song.find(params[:id])
  erb :'songs/edit'
end

put '/song-:id' do
  @song = Song.find(params[:id])
  @song.update_attributes(params[:song])
  if @song.save
    redirect "/song-#{@song.id}"
  else
    erb :'songs/show'
  end
end

delete '/song-:id' do
  @song = Song.find(params[:id])
  @song.destroy
  redirect '/'
end

delete '/song-:id/review-:rid' do 
  @song = Song.find(params[:id])
  @song.reviews.find(params[:rid]).destroy
  redirect "/song-#{params[:id]}"
end

post '/song-:id/vote' do
  logged_in = session[:user_id]
  @current_user = User.find(logged_in) if logged_in
  @song = Song.find(params[:id]) 
  
  if params[:upvote] && @current_user.can_vote?(@song, 'up')
    @current_user.upvote(@song)
  elsif params[:downvote] && @current_user.can_vote?(@song, 'down')
    @current_user.downvote(@song)
  end
  redirect '/' 
end 
