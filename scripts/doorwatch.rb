#!/bin/bash

#Door webcam capture

for i in 0..49
  open("tempImages/image#{i}.png", 'wb') do |file|
    file << open('http://hq.cirrusmio.com:82/media/?action=snapshot', http_basic_authentication: ["admin", "admin"]).read
    sleep(0.2)
    #print "Saving image#{i}.png"
  end
end





#Gif script

frames = 50
   gif = ImageList.new
frames.times do |i|
  gif.concat(ImageList.new("tempImages/image#{i}.png"))
end
gif.delay = 20
gif.ticks_per_second = 50 
gif.write("DOORCAPTURE.gif")




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

#Send a test message
Mail.deliver do
      to 'mtshro2@gmail.com, tyler.shipp@uky.edu'
    from 'cirrusmioat@gmail.com'
 subject 'testing sendmail'
    body 'testing sendmail'
  attachments['TestGif.gif'] = File.read('DOORCAPTURE.gif')
end