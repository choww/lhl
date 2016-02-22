# Homepage (Root path)
get '/' do
  @songs = Song.all
  erb :index
end

get '/new' do
  @song = Song.new 
  erb :new 
end 
 
post '/' do 
  @song = Song.new(title: params[:title], 
    author: params[:author], 
    url: params[:url] 
  ) 
  if @song.save 
    redirect '/'  
  else 
    erb :new 
  end 
end 

get '/:id' do
  @song = Song.find(params[:id])
  @more_songs = Song.where(author: @song.author).where.not(id: @song.id)
  erb :show
end 
