require 'bundler'

Bundler.require()

Dotenv.load


# ** Connection **
db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/volunteer_data')
ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)


# ** Models **
require './models/admin'
require './models/volunteer'


# ** Sessions **
enable(:sessions)   #this is for authentication


# ** Helpers **
def current_user
  if session[:current_user]
    Admin.find(session[:current_user])
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
  post '/sign_up' do
    admin = Admin.new(params[:name])
    admin.password = params[:password]   # Password hashing
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
    puts params # debug only.. comment out when done
    volunteer = Volunteer.new(params)
    first_name = params[:first_name]
    num = params[:phone_number]
    num.gsub!('-','')
    num.gsub!('(','')
    num.gsub!(')','')
    num.gsub!(' ','')    
    nexmo = Nexmo::Client.new(key: ENV['NEXTMO_KEY'], secret: ENV['NEXTMO_SEC'])
    nexmo.send_message(from: '12252446824', to: "#{num}", text: "Thanks for signing up to volunteer, #{first_name}")
    volunteer.save!
    redirect '/authenticated'
  end

  get '/authenticated' do
    erb :authenticated
  end

  # post '/admin' do
  #   admin = Admin.create(params[:user])
  #   redirect '/admin_authenticated'
  # end

  get '/admin' do
    erb :admin_signin
  end

  ##admin_authenticated
  get '/admin_authenticated' do
    erb :admin_authenticated
  end

  # ** Session Routes **
  # Sign-in
  # figure out why we're always redirected
  post '/admin_sign_in' do
    puts params
    admin = Admin.find_by(name: params[:name])
    if admin && admin.password = params[:password]
      session[:current_user] = admin.id
      redirect '/admin_authenticated'
    else
      redirect '/'
    end
  end

  # Sign-out
  delete '/sessions' do
    session[:current_user] = nil
    redirect '/'
  end


  # Admin Sign-out
  delete '/admin_signout' do
    session[:current_user] = nil
    redirect '/'
  end

  get '/api/volunteers' do
    volunteers = Volunteer.all
    return volunteers.to_json
  end


  #SMS Routes
