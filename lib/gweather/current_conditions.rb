require './lib/gweather.rb'

class CurrentConditions
  attr_reader :fahrenheit, :celsius, :condition, :humidity, :wind, :image_url

  def self.from_element(current)
    unless current.is_a?(Nokogiri::XML::Element)
      raise "must be of type Nokogiri::XML::Element" 
    end

    condition = current.condition.attributes["data"].value
    fahrenheit = current.temp_f.attributes["data"].value.to_i
    celsius = current.temp_c.attributes["data"].value.to_i
    humidity = current.humidity.attributes["data"].value[/\d+/].to_i / 100.0
    image_url = current.icon.attributes["data"].value
    wind = current.wind_condition.attributes["data"].value

    wind[/Wind: /] = ''
    
    new(fahrenheit, celsius, condition, humidity, wind, image_url)
  end

  def initialize(fahrenheit, celsius, condition, humidity, wind, image_url)
    @fahrenheit = fahrenheit
    @celsius = celsius
    @condition = condition
    @humidity = humidity
    @wind = wind
    @image_url = image_url
  end

  def temperature(fahren = true)
    return @fahrenheit if fahren
    @celsius    
  end
end