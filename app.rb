require 'bundler'
Bundler.require()


# ** Connection **
ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => 'volunteer_data'
)

# ** Models **
require './models/admin'
require './models/volunteer'


# ** Sessions **
enable(:sessions)


# ** Helpers **
def current_user
  if session[:current_user]
    User.find(session[:current_user])
  else
    nil
  end
end

def authenticate!
  redirect '/' unless current_user
end


# ** Routes **
get '/' do
  if current_user
    erb :authenticated
  else
    erb :not_authenticated
  end
end


  # ** Admin Routes **
  post '/admin' do
    admin = Admin.new(params[:user])
    admin.password= params[:password]  # Password hashing
    admin.save!
    redirect '/'
  end

  #** Volunteer Routes **

  # get '/volunteer' do
  #   # 'Hello World'
  #   	content_type :json
  #   	volunteers = Volunteer.all
  #   	volunteers.to_json
  # end
  #
  post '/volunteer' do
    volunteer = Volunteer.create(params[:user])
    redirect '/'
  end


  # ** Session Routes **
  # Sign-in
  post '/sessions' do
    redirect '/' unless admin = Admin.find_by(username: params[:username])
    if admin.password == params[:password]
      session[:current_user] = user.id
      redirect '/'
    else
      redirect '/'
    end
  end

  # Sign-out
  delete '/sessions' do
    session[:current_user] = nil
    redirect '/'
  end
