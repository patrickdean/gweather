require 'nokogiri'
require 'open-uri'
Dir["./lib/gweather/*.rb"].each do |file| 
  require file 
end
