# tahta.rb
require "sinatra/base"
require 'sinatra/activerecord'
require 'json'

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "localhost",
  :username => "dashboard",
  :password => "dashboard",
  :database => "dashboard"
)

class Dashboards < ActiveRecord::Base
end

class Widgets < ActiveRecord::Base
end

class Tahta < Sinatra::Base
   enable :logging

   get '/' do
      send_file File.join(settings.public_folder, 'index.html')
   end

   get '/dashboards' do
      p Dashboards.all
   end

   get '/dashboard/:name' do |n|
      p Widgets.all
   end
end