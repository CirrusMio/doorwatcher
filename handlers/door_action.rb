#requirements
require 'mail'
require "rubygems"
require 'open-uri'
require "rmagick"
include Magick
require_relative '../lib/authentication.rb'

# DoorAction class. Sinatra base class that handles all actions once the door 
# is opened/doorbell is rang. 
# Methods: capture, gifify, sendit
class DoorAction < Sinatra::Base
  include Authentication
  
  #Authentication
  before '/door/*' do
    if authenticate(params[:token])
    else
      halt 403, haml('Access Denied')
    end
  end
  
  #capture method
  #Captures 50 frames from an IP camera. 5 frames per second for a 10s gif
  def capture
    for i in 0..49
	   open("tempImages/image#{i}.png", 'wb') do |file|
	   file << open('http://hq.cirrusmio.com:82/media/?action=snapshot', http_basic_authentication: ["admin", "admin"]).read
	   sleep(0.2)
	end
    end
  end

  #gifify method
  #Uses Imagemagick to compile a gif from the image files in 
  #the tempImage directory 
  def gifify
	frames = 50
        gif = ImageList.new
	frames.times do |i|
	   gif.concat(ImageList.new("tempImages/image#{i}.png"))
	end
	gif.delay = 20
	gif.ticks_per_second = 50 
	gif.write("DOORCAPTURE.gif")
  end
  
  #sendit method
  #Uses Ruby Mail gem to send an email to pre-set users with 
  #the gif file attached.
  def sendit
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

    #Send the email with .gif attached
    Mail.deliver do
          to 'mtshro2@gmail.com, tyler.shipp@uky.edu, mcortt@gmail.com'
        from 'cirrusmioat@gmail.com'
     subject 'DoorWatcher'
        body 'Capture from DoorWatcher'
    attachments['DOORCAPTURE.gif'] = File.read('DOORCAPTURE.gif')
	
    end
  end
  
  #Lambdas for capture, gifify, and sendit 
  #so as not to duplicate code for both GET and POST methods 
  capturing = lambda do
    capture
    "Capturing images from camera... Please wait \n"
  end

  gififying = lambda do
    gifify
    "Gififying..."
  end 

  sending = lambda do
    sendit
    "Email sent!"
  end

  #GETs and POSTs for all methods DEPRACATED
  #get '/dooropen' , &dooropen
  #post '/dooropen' , &dooropen
  #get '/capture' , &capturing
  #post '/capture' , &capturing
  #get '/gifify' , &gififying
  #post '/gifify' , &gififying
  #get '/sendit' , &sending
  #post '/sendit', &sending
  
  #GET/POST /door calls all methods in sequence. This is the primary means
  #requesting a gif capture
  get '/door' do 
    capture
    gifify
    sendit
    "Someone was at the door. .gif captured and sent\n"
  end
  post '/door' do
    capture
    gifify
    sendit
    "Someone was at the door. .gif captured and sent\n"
  end  
end
