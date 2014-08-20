# coding: UTF-8
require 'sinatra'
require 'sinatra/reloader'
require 'slim'

require 'cgi'

require 'active_record'


Slim::Engine.set_default_options pretty: true, sort_attrs: false

# set envirment: :production
set server: "thin"

connections = []

get '/' do
  slim :index
end

get '/stream', provides: 'text/event-stream' do
  stream :keep_open do |out|
    connections << out
    out.callback{connections.delete out}
  end
end

post '/' do
  connections.each do |out|
    out << "data: #{params[:msg].escape}\n\n"
  end
  204
end

class String
  def escape
    CGI.escapeHTML(self)
  end
end



ActiveRecord::Base.establish_connenction(
  adapter: "sqlite3",
  database: "./post.db"
)

# save chat-log as database
# 
class Post < ActiveRecord::Base
  
  def self.glance
  
  end
end

