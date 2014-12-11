require 'mail'
require "rubygems"
require 'open-uri'
require "rmagick"
include Magick
require_relative '../lib/authentication.rb'
class DoorAction < Sinatra::Base
  include Authentication

  before '/dooropen/*' do
    if authenticate(params[:token])
    else
      halt 403, haml('Access Denied')
    end
  end

  #dooropen method
  dooropen = lambda do
    `say who`
    "I just said who but you can't hear me cause you're on a VM! \n"
  end
  
  #capture method
  capture = lambda do
    for i in 0..49
	   open("tempImages/image#{i}.png", 'wb') do |file|
	   file << open('http://hq.cirrusmio.com:82/media/?action=snapshot', http_basic_authentication: ["admin", "admin"]).read
	   sleep(0.2)
	   print "Saving image#{i}.png \n"
	end
  end

  #gifify method
  gifify = lambda do
	frames = 50
       gif = ImageList.new
	frames.times do |i|
	   gif.concat(ImageList.new("tempImages/image#{i}.png"))
	   "Adding frame: image#{i}.png \n"
	end
	gif.delay = 20
	gif.ticks_per_second = 50 
	"Writing DOORCAPTURE.gif\n"
	gif.write("DOORCAPTURE.gif")
  end
  
  #sendit method
  sendit = lambda do
    #Email script
    options = { :address              => "smtp.gmail.com",
                :port                 => 587,
                :domain               => 'gmail.com',
                :user_name            => 'cirrusmioat',
                :password             => 'soserious',
                :authentication       => 'plain',
                :enable_starttls_auto => true  }

    #Apply options
    Mail.defaults do
    delivery_method :smtp, options
    end

    #Send a the email with .gif attached
    Mail.deliver do
          to 'mtshro2@gmail.com, tyler.shipp@uky.edu, mcortt@gmail.com'
        from 'cirrusmioat@gmail.com'
     subject 'DoorWatcher'
        body 'Capture from DoorWatcher'
    attachments['DOORCAPTURE.gif'] = File.read('DOORCAPTURE.gif')
	
	"Email sent"
  end
  
  get '/dooropen' , &dooropen
  post '/dooropen' , &dooropen
  
  get '/capture' , &capture
  post '/capture' , &capture
  
  get '/gifify' , &gifify
  get '/gifify' , &gifify
  
  get '/sendit' , &sendit
  get '/sendit' , &sendit
  
  get '/demo' , &capture &gifify &sendit
  post '/demo' , &capture &gifify &sendit
  
end
