#Test file for .gif concatenation
#TBD
#https://gist.github.com/grough/1988486
#http://rubygems.org/gems/rmagick
#Installing rmagick gem in Ubuntu:
#sudo aptitude Install Imagemagick and GraphicsMagick(If not aptitude go & install in s/w center) 
#sudo aptitude Install libmagickcore-dev libmagickwand-dev gem install rmagick -v 2.13.1
#require 'bundler/setup'
require "rubygems"
require "rmagick"
include Magick
 
frames = 100
   gif = ImageList.new
 
frames.times do |i|
  colour = "#"; 3.times {
    colour << "%02X" % (rand * 256)
  }
  gif << Image.new(130,50).color_fill_to_border(1, 1, colour)
end
 
gif.write("00-#{frames}-colours.gif")
