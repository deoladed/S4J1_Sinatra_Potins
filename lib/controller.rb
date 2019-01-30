require 'gossip'
require 'comment'

class ApplicationController < Sinatra::Base

	get '/' do
		erb :index, locals: {gossips: Gossip.all}
	end

	get '/gossips/new/' do
		erb :new_gossip
	end

	post '/gossips/new/' do
		Gossip.new(params["gossip_author"], params["gossip_content"]).save
		redirect '/'
	end

	get '/gossips/*/' do
		erb :gossip, locals: {gossips_id: Gossip.id(params['splat'][0].to_i), comment: Coment.all}
	end

	post '/gossips/*/' do
		Coment.new(params["splat"][0].to_i, params['user'], params['comment']).create_comment
		redirect "/gossips/#{params["splat"][0].to_i}/"
	end

	get '/gossips/*/edit' do
		erb :editgossip, locals: {gossips_id: Gossip.id(params['splat'][0].to_i)}
	end

	post '/gossips/*/edit/*' do
		Gossip.editgossip(params['splat'][0].to_i, params["gossip_author"], params["gossip_content"])
		redirect '/'
	end
	# get '/gossips/:id' do
	# 	params = ('id').to_s
	# 	erb :gossip {gossips_id: Gossip.id("01")}
	# end
end


# get '/say/*/to/*' do
#   # matches /say/hello/to/world
#   params['splat'] # => ["hello", "world"]
# end

# get '/download/*.*' do
#   # matches /download/path/to/file.xml
#   params['splat'] # => ["path/to/file", "xml"]
# end

# get %r{/hello/([\w]+)} do |c|
#   # Matches "GET /meta/hello/world", "GET /hello/world/1234" etc.
#   "Hello, #{c}!"
# end
# 
# get '/hello/:name' do
  # matches "GET /hello/foo" and "GET /hello/bar"
  # params['name'] is 'foo' or 'bar'
#   "Hello #{params['name']}!"
# end

# You can also access named parameters via block parameters:

# get '/hello/:name' do |n|
#   # matches "GET /hello/foo" and "GET /hello/bar"
#   # params['name'] is 'foo' or 'bar'
#   # n stores params['name']
#   "Hello #{n}!"
# end
