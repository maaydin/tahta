# tahta.rb
require "sinatra/base"
require 'json'

class Tahta < Sinatra::Base
   enable :logging

   get '/' do
      send_file File.join(settings.public_folder, 'index.html')
   end

   get '/dashboard' do
      content_type :json
      ""
   end

   get '/dashboard/:name' do |n|
      content_type :json
      ""
   end
end