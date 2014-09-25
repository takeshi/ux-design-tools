require 'sinatra'
require "sinatra/json"
require './server/db'


class MainApp < Sinatra::Base

  set :root, File.dirname(__FILE__)
  set :public_folder, Proc.new { File.join(root, "dist") }

  configure :development do 
    require "sinatra/reloader" 
    Bundler.require :development 
    register Sinatra::Reloader
    # Mongoid.logger.level = Logger::DEBUG
    # Mongoid.logger = Logger.new($stdout)
    enable :logging
    # DB.loggers << Logger.new($stdout)
  end 
  
  get '/' do
    File.read(File.join('dist', 'index.html'))
   end

end

require './server/service'
