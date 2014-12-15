require 'rubygems'
require 'mysql2'
require 'active_record'
require 'yaml'
require 'json'
require 'sinatra'


ActiveRecord::Base.configurations["mydatabase"] = YAML::load(File.open('database.yml'))

class Quote < ActiveRecord::Base
  #set_table_name "quotes"
  self.table_name = 'quotes'
  establish_connection "mydatabase"

  belongs_to :author  # v tbl Quote est colonka author_id
                      # i y nas est tablica s nazvanijem 'authors
                      # po tomy kogda mi propisuvajem pravilo 'belongs_to :author'
                      # mu soobschaem ActiRecord chtob kogda mu vizivajem 'quote.author'
                      # on bydet brat pole 'author_id' po nemy iskat zapis v tabl 'Authors'
  belongs_to :source
end

class Source < ActiveRecord::Base
  self.table_name = 'sources'
  establish_connection "mydatabase"

  belongs_to :author
  has_many :quotes
end

class Author < ActiveRecord::Base
  self.table_name = 'authors'
  establish_connection "mydatabase"

  has_many :quotes #etogo mozhna ne pisat, esli ne ispolzovat poisk vseh citat avtora, no esli nyzhno to

  has_many :sources
end

begin
set :public_folder, 'www'

get '/' do
  send_file 'www/index.html'
end

get '/quotes' do
  Quote.all.to_json
  #if you change code you need to restart server!
end

get '/authors' do
  Author.all.to_json
end

get '/sourses' do
  Source.all.to_json
end

post '/quotes' do
  content_type :json
  p params
  #{"author"=>"Марк Аврелий", "sourse"=>"наедине с собой", "phrase"=>"123"}
  author = Author.find_or_create_by(name: params[:author])
  source = author.sources.find_or_create_by(name: params[:source])

  @quote = author.quotes.new(body: params[:phrase], source_id: source.id)

  if @quote.save
    @quote.to_json
  else
    halt 500
  end
end

get '/authors_list' do
  @authors = Author.all
  #@authors.each do |author|
    #puts author.name
  #end
  p '='*10
  p Author.all.to_json
  #[].to_json
end

get '/sourses_list' do
  @sourses = Source.all
  @sourses.each do |sourse|
    puts sourse.name
  end
  Source.all.to_json
end

end
