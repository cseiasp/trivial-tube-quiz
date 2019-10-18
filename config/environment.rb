require 'rake'
require 'active_record'
require 'bundler'
require 'date'

Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/game.db')
require_all 'lib'


