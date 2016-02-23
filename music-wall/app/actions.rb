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
  @user = session[:user_id]
  @song = @user.songs.new 
  erb :'songs/new' 
end 
 
post '/new-song' do 
  @user = session[:user_id]
  @song = @user.songs.new(
    title: params[:title], 
    author: params[:author], 
    url: params[:url] 
  ) 
  if @song.save 
    redirect '/'  
  else 
    erb :'songs/new' 
  end 
end 

get '/user-:uid/song-:id' do
  @user = User.find(params[:uid])
  @song = Song.find(params[:id])
  @more_songs = @user.songs.where.not(id: @song.id)
  erb :'songs/show'
end 

post '/song-:id/upvote' do
  logged_in = session[:user_id]
  @current_user = User.find(logged_in) if logged_in
  @song = Song.find(params[:id]) 
  if session[:votes].include?(@song.id)
    erb :index
  else 
    session[:votes] << @song.id
    @song.upvote
    redirect '/'
 end
end 
