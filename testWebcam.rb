#Test file for image capture
require 'open-uri'


#Authentication necessary?
open('image.png', 'wb') do |file|
  file << open('http://hq.cirrusmio.com:82/media/?action=snapshot', http_basic_authentication: ["admin", "admin"]).read
end