require 'rubygems'
require 'mysql2'
require 'active_record'
require 'yaml'
require 'json'
require 'sinatra'

ActiveRecord::Base.configurations["mydatabase"] = YAML::load(File.open('database.yml'))

class Quotations < ActiveRecord::Base
  set_table_name "quotations"
  establish_connection "mydatabase"
end

set :public_folder, 'www'

get '/' do
  send_file 'www/index.html'
end

get '/quotations' do
  Quotations.all
end