require_relative '../lib/authentication.rb'
class DoorBell < Sinatra::Base
  include Authentication

  before '/doorbell/*' do
    if authenticate(params[:token])
    else
      halt 403, haml('Access Denied')
    end
  end

  doorbell = lambda do
    `say what`
  end

  get '/doorbell' , &doorbell
  post '/doorbell' , &doorbell

  get '/what' do
    'ok'
  end
end
