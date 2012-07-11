require 'nokogiri'
require 'open-uri'
require 'pry'

Dir["./lib/gweather/*.rb"].each do |file| 
  require file 
end

