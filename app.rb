require 'bundler/setup'
require 'sinatra'
require 'yaml'
require 'ipaddr'
require 'active_support/all'
require 'haml'
require 'mail'
#require 'rubygems'
require 'rmagick'
require 'open-uri'
include Magick

class DoorWatcher < Sinatra::Base
  # include modules
  Dir.glob('lib/*.rb').each do |mod|
    require_relative File.expand_path(mod)
    include File.basename(mod, '.rb').camelize.constantize
  end

  # use Sinatra middlewares
  Dir.glob('handlers/*.rb').each do |handler|
    require_relative File.expand_path(handler)
    use File.basename(handler, '.rb').camelize.constantize
  end

  configure do
    enable :logging
    file = File.new("#{settings.root}/log/doorwatcher.log", 'a+')
    file.sync = true
    use Rack::CommonLogger, file
  end

  get '/' do
    haml :index
  end

  get '/status' do
    haml :status
  end


  # Return a key if the incoming request is from an internal network
  # Save the key to the whitelist
  get '/key' do
    config = YAML.load_file('config.yml')
    if subnet=config['subnet']
      internal = IPAddr.new(subnet)
      incoming = IPAddr.new(request.ip)
      if internal.include?(incoming)
        key = SecureRandom.hex
        whitelist ||= []
        whitelist.push(key)
        File.open('whitelist.yml', 'w') {|f| f.write(whitelist.to_yaml) }
        key
      end
    end
  end
end
