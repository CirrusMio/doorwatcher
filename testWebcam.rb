#Test file for image capture
require 'open-uri'


#Authentication necessary?
for i in 0..49
  open("tempImages/image#{i}.png", 'wb') do |file|
    file << open('http://hq.cirrusmio.com:82/media/?action=snapshot', http_basic_authentication: ["admin", "admin"]).read
    sleep(0.2)
    print "Saving image#{i}.png"
  end
end
