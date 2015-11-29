# tahta.rb
require "sinatra/base"
require 'sinatra/activerecord'
require 'json'

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "127.0.0.1",
  :username => "dashboard",
  :password => "dashboard",
  :database => "dashboard",
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

   get '/api/dashboard' do
      data = {}
      data["dashboards"] = Dashboards.all
      return data.to_json;
   end

   get '/api/dashboard/:name' do |name|
      data = {}
      data["widgets"] = Widgets.select('widgets.id, widgets.colspan, widgets.rowspan, widgets.title, widgets.widget_type, instant_data_providers.adapter as `instant_data_provider_type`, instant_data_providers.connection_string as `instant_data_provider_connection_string`, widgets.instant_data_query, widgets.config')
         .joins('INNER JOIN dashboards ON dashboards.id = widgets.dashboard_id LEFT JOIN instant_data_providers ON instant_data_providers.id = widgets.instant_data_provider_id')
         .where("dashboards.name = ?", name)
         .order(:index)
         .to_a.map(&:serializable_hash)
      data["widgets"].map do |widget|
         widget["config"] = JSON.parse(widget["config"])
      end
      return data.to_json;
   end
end