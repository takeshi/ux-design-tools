require 'mongoid'
Mongoid.load!("mongoid.yml")


dirname = File.dirname(__FILE__) + "/mongo"

require dirname + '/user'