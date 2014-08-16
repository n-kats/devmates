# coding: UTF-8
require 'sinatra'
require 'sinatra/reloader'
require 'slim'

set envirment: :production,
  server: "thin"

get '/' do
  slim :index
end

post '/' do
  params.to_s
end
