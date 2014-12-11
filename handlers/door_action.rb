require_relative '../lib/authentication.rb'
class DoorAction < Sinatra::Base
  include Authentication

  before '/dooropen/*' do
    if authenticate(params[:token])
    else
      halt 403, haml('Access Denied')
    end
  end

  dooropen = lambda do
    `say who`
    "I just said who but you can't hear me cause you're on a VM! \n"
  end

  get '/dooropen' , &dooropen
  post '/dooropen' , &dooropen
end
