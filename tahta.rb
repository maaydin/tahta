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
      data["dashboards"] = []
      Dashboards.all.each do |dashboard|
        dashboards = {}
        dashboards["id"] = dashboard.DASHBOARD_ID.to_s
        dashboards["name"] = dashboard.NAME
        dashboards["title"] = dashboard.TITLE
        data["dashboards"].push(dashboards)
      end
      return data.to_json;
   end

   get '/api/dashboard/:name' do |name|
      data = {}
      data["widgets"] = []
      Widgets.joins('INNER JOIN dashboards ON dashboards.dashboard_id = widgets.dashboard_id').where("dashboards.name = ?", name).each do |widget|
        widgets = {}
        widgets["id"] = widget.WIDGET_ID.to_s
        widgets["title"] = widget.TITLE
        widgets["type"] = widget.TYPE
        widgets["config"] = JSON.parse(widget.CONFIG)
        data["widgets"].push(widgets)
      end
      return data.to_json;
   end
end