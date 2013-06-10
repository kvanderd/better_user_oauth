enable :sessions

get '/' do
  # Look in app/views/index.erb
  erb :index
end


post '/create' do
  User.create(params[:email],
              params[:password])
  redirect '/success'
end

get '/success' do
  if session[:valid]
    erb :success
  else
    erb :index
  end
end


post '/login' do
  session[:valid] = User.authenticate(params[:email],
                           params[:password])
  
    if session[:valid]
      erb :success
    else
    redirect '/'
   end
end

post '/logout' do
  session.clear
  redirect '/'
end


