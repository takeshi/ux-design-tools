require 'sequel'
require 'logger'

DB = Sequel.connect('sqlite://cardsort.db')
Sequel::Model.plugin :json_serializer

# configure :development do 
  DB.loggers << Logger.new($stdout)
# end

dirname = File.dirname(__FILE__) + "/db"

require dirname + '/user'
require dirname + '/theme'
require dirname + '/card'

