require_relative '../lib/authentication.rb'
class DoorOpen < Sinatra::Base
  include Authentication

  configure do
    enable :logging
    file = File.new(File.expand_path('log/doorwatcher.log'), 'a+')
    file.sync = true
    use Rack::CommonLogger, file
  end

  before '/doorwatch/*' do
    if authenticate(params[:token])
    else
      halt 403, haml('Access Denied')
    end
  end

  doorwatch = lambda do
    `doorwatch #{params[:words]}` if params
#	^^^Need to verify parameters
  end

  get '/doorwatch' , &doorwatch
  post '/doorwatch' , &doorwatch
end
